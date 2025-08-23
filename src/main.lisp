(defpackage ningle-email
  (:use :cl)
  (:export #:mail-admins
           #:send-email))

(in-package ningle-email)

(defun mail-admins (subject message)
  "Sends an email to the admins"
  (let ((project-name (envy-ningle:get-config :project-name))
        (admins (envy-ningle:get-config :email-admins)))
    (send-mail (format nil "[~A]: ~A" project-name subject) message admins)))

(defun send-mail (subject message to &key (from (envy-ningle:get-config :email-default-from)))
  "Sends arbitrary email"
  (let ((email-backend (envy-ningle:get-config :email-backend)))
    (case email-backend
        (:dummy
            (format t "from: ~A~%to: ~A~%subject: ~A~%content: ~A~%" from to subject message))

        (:smtp
            (cl-smtp:send-email
                (envy-ningle:get-config :email-smtp-host)
                from
                to
                subject
                message
                :port (or (envy-ningle:get-config :email-port) 587)
                :ssl (or (envy-ningle:get-config :email-ssl) :starttls)
                :authentication (envy-ningle:get-config :email-auth)))

        (:sendgrid
            (sendgrid:send-email
                :to to
                :from from
                :subject subject
                :content message
                :api-key (envy-ningle:get-config :sendgrid-api-key)))

        (otherwise
            (error "Unknown email backend: ~A" email-backend)))))
