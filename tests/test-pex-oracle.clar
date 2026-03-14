;; PEX Oracle Contract Tests
;; Unit tests for the oracle consensus mechanism

(define-test "oracle-registration"
  (begin
    ;; Register primary oracle
    (assert-ok (contract-call? pex-oracle register-oracle 'SP2TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX))))

(define-test "oracle-activation-status"
  (begin
    ;; Check if oracle is marked as active
    (match (contract-call? pex-oracle get-oracle-info 'SP2TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX)
      info (begin
        (assert-eq (get is-active info) true))
      (assert false "Oracle should be registered"))))

(define-test "price-submission"
  (begin
    ;; Test price submission by oracle
    ;; Price should be recorded with timestamp
    (assert-ok (contract-call? pex-oracle submit-price "STX" u500000 block-height))))

(define-test "price-retrieval"
  (begin
    ;; Test price retrieval for collateral type
    (match (contract-call? pex-oracle get-price "STX")
      price (assert-eq price u500000)
      (assert false "Price should be available"))))

(define-test "oracle-deactivation"
  (begin
    ;; Test deactivating an oracle
    (assert-ok (contract-call? pex-oracle deactivate-oracle 'SP2TXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX))))
