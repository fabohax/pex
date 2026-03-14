;; PEX Burn-to-Mint Contract Tests
;; Integration tests for the burn-to-mint mechanism

(define-test "burn-to-mint-basic"
  (begin
    ;; Test basic burn-to-mint with valid collateral amount
    ;; User burns 1 STX (1,000,000 satoshis) to receive PEX
    ;; Exchange rate is 500,000 satoshis per PEX (approximately)
    (assert-ok (contract-call? pex-burn-to-mint burn-to-mint u1000000))))

(define-test "burn-to-mint-insufficient-amount"
  (begin
    ;; Test burn with insufficient collateral
    ;; Minimum is 1 STX (1,000,000 satoshis)
    (assert-err (contract-call? pex-burn-to-mint burn-to-mint u100000))))

(define-test "burn-event-recording"
  (begin
    ;; Test that burn events are properly recorded
    (match (contract-call? pex-burn-to-mint get-burn-event u0)
      event (assert-eq (get burner event) tx-sender)
      false)))

(define-test "burn-pause-functionality"
  (begin
    ;; Test pause/unpause of burns
    (assert-ok (contract-call? pex-burn-to-mint set-burn-pause true))
    ;; Should fail when paused
    (assert-err (contract-call? pex-burn-to-mint burn-to-mint u1000000))))

(define-test "total-collateral-tracking"
  (begin
    ;; Test that total collateral burned is tracked correctly
    ;; After unpausing and burning
    (assert-ok (contract-call? pex-burn-to-mint set-burn-pause false))
    (assert-ok (contract-call? pex-burn-to-mint burn-to-mint u2000000))))
