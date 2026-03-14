;; PEX Token Contract Tests
;; Unit tests for the PEX token implementation

(define-test "token-initialization"
  (begin
    (try! (contract-call? pex-token initialize-token
      "PEX"
      "PEX"
      u8))
    (assert-eq (contract-call? pex-token get-token-name) "PEX")
    (assert-eq (contract-call? pex-token get-token-decimals) u8)))

(define-test "token-balance-tracking"
  (begin
    ;; Simulate minting via burn-to-mint
    (assert-eq (contract-call? pex-token get-balance tx-sender) u0)))

(define-test "token-burn-functionality"
  (begin
    ;; Test burn operation
    ;; Should fail if user doesn't have enough balance
    (assert-err (contract-call? pex-token burn u1000))))

(define-test "token-metadata-retrieval"
  (begin
    (assert-eq (contract-call? pex-token get-token-symbol) "PEX")
    (assert-eq (contract-call? pex-token get-total-supply) u0)))
