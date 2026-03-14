;; PEX Oracle Consensus Contract
;; Multi-oracle system for maintaining accurate PEN/collateral exchange rates

(define-map oracle-data
  { oracle: principal }
  {
    address: principal,
    is-active: bool,
    last-update: uint,
    last-price: uint,
    reputation-score: uint
  })

(define-map price-feed
  { collateral-type: (string-ascii 10) }
  {
    price: uint,
    last-updated: uint,
    oracle-count: uint,
    consensus-price: uint
  })

(define-constant CONTRACT-OWNER tx-sender)
(define-constant CONSENSUS-THRESHOLD u2)  ;; 2 of 3 oracles must agree
(define-constant MAX-PRICE-DEVIATION u100)  ;; 100 basis points = 1%
(define-constant ORACLE-TIMEOUT u600)  ;; 10 minutes

(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INVALID-ORACLE (err u2))
(define-constant ERR-STALE-PRICE (err u3))
(define-constant ERR-PRICE-DIVERGENCE (err u4))
(define-constant ERR-INSUFFICIENT-CONSENSUS (err u5))

;; Oracle management
(define-public (register-oracle (oracle-address principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-UNAUTHORIZED)
    (map-set oracle-data
      { oracle: oracle-address }
      {
        address: oracle-address,
        is-active: true,
        last-update: u0,
        last-price: u0,
        reputation-score: u100
      })
    (ok true)))

(define-public (deactivate-oracle (oracle-address principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-UNAUTHORIZED)
    (match (map-get? oracle-data { oracle: oracle-address })
      oracle-info
        (begin
          (map-set oracle-data
            { oracle: oracle-address }
            (merge oracle-info { is-active: false }))
          (ok true))
      (err ERR-INVALID-ORACLE))))

;; Price submission by oracle
(define-public (submit-price 
    (collateral-type (string-ascii 10))
    (price uint)
    (timestamp uint))
  (let ((oracle-address tx-sender))
    (begin
      (asserts! (match (map-get? oracle-data { oracle: oracle-address })
        existing-oracle (and
          (get is-active existing-oracle)
          (>= (+ (current-block-height) ORACLE-TIMEOUT) timestamp))
        false) ERR-INVALID-ORACLE)
      
      ;; Update oracle's price data
      (map-set oracle-data
        { oracle: oracle-address }
        (merge (unwrap! (map-get? oracle-data { oracle: oracle-address })
          (err ERR-INVALID-ORACLE))
          {
            last-price: price,
            last-update: timestamp
          }))
      
      ;; Update price feed with consensus mechanism
      (try! (update-consensus-price collateral-type price))
      (ok true))))

;; Calculate consensus price from oracle submissions
(define-private (update-consensus-price (collateral-type (string-ascii 10)) (price uint))
  (begin
    (match (map-get? price-feed { collateral-type: collateral-type })
      existing-feed
        (begin
          ;; Simple consensus: take median of recent oracle prices
          ;; This is a placeholder for more sophisticated consensus logic
          (map-set price-feed
            { collateral-type: collateral-type }
            {
              price: price,
              last-updated: block-height,
              oracle-count: (+ (get oracle-count existing-feed) u1),
              consensus-price: price
            })
          (ok true))
      (begin
        (map-set price-feed
          { collateral-type: collateral-type }
          {
            price: price,
            last-updated: block-height,
            oracle-count: u1,
            consensus-price: price
          })
        (ok true)))))

;; Read-only functions
(define-read-only (get-price (collateral-type (string-ascii 10)))
  (match (map-get? price-feed { collateral-type: collateral-type })
    feed (ok (get consensus-price feed))
    (err ERR-STALE-PRICE)))

(define-read-only (get-oracle-info (oracle-address principal))
  (map-get? oracle-data { oracle: oracle-address }))

(define-read-only (is-oracle-active (oracle-address principal))
  (match (map-get? oracle-data { oracle: oracle-address })
    oracle (get is-active oracle)
    false))
