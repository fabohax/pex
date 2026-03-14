;; PEX Token Contract
;; Implements a SIP-010 fungible token for the Synthetic Peruvian Sol

(define-fungible-token pex)

(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))

;; Token metadata
(define-data-var token-name (string-ascii 32) "PEX")
(define-data-var token-symbol (string-ascii 10) "PEX")
(define-data-var token-decimals uint u8)

;; Minting and burning
(define-data-var total-burned uint u0)
(define-data-var total-minted uint u0)

;; Initialize token metadata
(define-public (initialize-token 
    (name (string-ascii 32))
    (symbol (string-ascii 10))
    (decimals uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-UNAUTHORIZED)
    (var-set token-name name)
    (var-set token-symbol symbol)
    (var-set token-decimals decimals)
    (ok true)))

;; Mint new PEX tokens (called by burn-to-mint contract)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender (contract-of burn-to-mint))
      ERR-UNAUTHORIZED)
    (ft-mint? pex amount recipient)
    (var-set total-minted (+ (var-get total-minted) amount))
    (ok true)))

;; Burn PEX tokens (user-initiated)
(define-public (burn (amount uint))
  (begin
    (asserts! (>= (ft-get-balance pex tx-sender) amount)
      ERR-INSUFFICIENT-BALANCE)
    (ft-burn? pex amount tx-sender)
    (var-set total-burned (+ (var-get total-burned) amount))
    (ok true)))

;; Read-only functions
(define-read-only (get-balance (owner principal))
  (ft-get-balance pex owner))

(define-read-only (get-total-supply)
  (ft-get-supply pex))

(define-read-only (get-token-name)
  (var-get token-name))

(define-read-only (get-token-symbol)
  (var-get token-symbol))

(define-read-only (get-token-decimals)
  (var-get token-decimals))

(define-read-only (get-total-minted)
  (var-get total-minted))

(define-read-only (get-total-burned)
  (var-get total-burned))

;; Reference to burn-to-mint contract
(define-constant burn-to-mint 'TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0)
