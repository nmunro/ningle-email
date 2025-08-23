(defpackage ningle-email/tests/main
  (:use :cl
        :ningle-email
        :rove))
(in-package :ningle-email/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :ningle-email)` in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
  (format t "Testing~%")
    (ok (= 1 1))))
