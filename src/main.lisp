(defpackage ningle-email
  (:use :cl)
  (:export #:mail-admins
           #:send-mail))

(in-package ningle-email)

(defun mail-admins (subject message)
  "Sends an email to the admins"
  (let ((project-name (envy-ningle:get-config :project-name))
        (admins (envy-ningle:get-config :email-admins)))
    (send-mail (format nil "[~A]: ~A" project-name subject) message admins)))

(defun send-mail (subject content to &key (from (envy-ningle:get-config :email-default-from)))
  "Sends arbitrary email"
  (let ((email-backend (envy-ningle:get-config :email-backend)))
    (case email-backend
        (:dummy
         (progn
            (format t "from: ~A~%" from)
            (format t "to: ~A~%" to)
            (format t "subject: ~A~%" subject)
            (format t "content: ~A~%" content)))

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
