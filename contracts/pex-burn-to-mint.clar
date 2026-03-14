;; PEX Burn-to-Mint Contract
;; Implements the one-way burn mechanism for PEX minting

(use-trait ft-trait 'TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0)

(define-map burn-events
  { burn-id: uint }
  {
    burner: principal,
    collateral-amount: uint,
    pex-minted: uint,
    exchange-rate: uint,
    timestamp: uint,
    tx-id: (buff 32)
  })

(define-data-var next-burn-id uint u0)
(define-data-var total-collateral-burned uint u0)
(define-data-var burn-pause bool false)

(define-constant CONTRACT-OWNER tx-sender)
(define-constant MIN-BURN-AMOUNT u1000000)  ;; 1 STX in satoshis
(define-constant COLLATERAL-TYPE "STX")

(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INVALID-AMOUNT (err u2))
(define-constant ERR-BURN-PAUSED (err u3))
(define-constant ERR-ORACLE-FAILURE (err u4))
(define-constant ERR-INSUFFICIENT-BALANCE (err u5))

;; Main burn-to-mint function
;; User burns collateral (STX) to receive PEX at the oracle exchange rate
(define-public (burn-to-mint (collateral-amount uint))
  (let (
    (burn-id (var-get next-burn-id))
    (exchange-rate (try! (oracle-get-price)))
    (pex-amount (/ (* collateral-amount exchange-rate) u1000000))
    )
    (begin
      ;; Validation
      (asserts! (not (var-get burn-pause)) ERR-BURN-PAUSED)
      (asserts! (>= collateral-amount MIN-BURN-AMOUNT) ERR-INVALID-AMOUNT)
      
      ;; Burn collateral (STX)
      (try! (stx-burn? collateral-amount tx-sender))
      
      ;; Mint PEX to user
      (try! (token-mint pex-amount tx-sender))
      
      ;; Record burn event
      (map-set burn-events
        { burn-id: burn-id }
        {
          burner: tx-sender,
          collateral-amount: collateral-amount,
          pex-minted: pex-amount,
          exchange-rate: exchange-rate,
          timestamp: block-height,
          tx-id: tx-id
        })
      
      ;; Update totals
      (var-set total-collateral-burned 
        (+ (var-get total-collateral-burned) collateral-amount))
      (var-set next-burn-id (+ burn-id u1))
      
      (ok { burn-id: burn-id, pex-minted: pex-amount, exchange-rate: exchange-rate }))))

;; Admin function to pause/unpause burns
(define-public (set-burn-pause (paused bool))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-UNAUTHORIZED)
    (var-set burn-pause paused)
    (ok paused)))

;; Oracle price retrieval
(define-private (oracle-get-price)
  (match (contract-call? (oracle) get-price COLLATERAL-TYPE)
    price (ok price)
    (err ERR-ORACLE-FAILURE)))

;; Token mint wrapper
(define-private (token-mint (amount uint) (recipient principal))
  (begin
    ;; This calls the PEX token contract mint function
    ;; In actual deployment, use proper contract reference
    (ok true)))

;; Admin burn event queries
(define-read-only (get-burn-event (burn-id uint))
  (map-get? burn-events { burn-id: burn-id }))

(define-read-only (get-total-collateral-burned)
  (var-get total-collateral-burned))

(define-read-only (get-is-paused)
  (var-get burn-pause))

(define-read-only (get-next-burn-id)
  (var-get next-burn-id))

;; Contract references (to be set at deployment)
(define-constant oracle 'TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0)
(define-constant pex-token 'TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX1)
