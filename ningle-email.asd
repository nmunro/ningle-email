(defsystem "ningle-email"
  :version "0.0.1"
  :author "nmunro"
  :license "BSD3-Clause"
  :description ""
  :depends-on (:envy-ningle
               :cl-smtp
               :sendgrid)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :in-order-to ((test-op (test-op "ningle-email/tests"))))

(defsystem "ningle-email/tests"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("ningle-email"
               :rove)
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for ningle-email"
  :perform (test-op (op c) (symbol-call :rove :run c)))
