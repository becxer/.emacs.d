;;;
;;; becxer's GNUS configuration
;;;
;;; @ author becxer
;;; @ e-mail becxer87@gmail.com
;;; 
;;; To install this option, copy this file to ~/.gnus.el

;;; Personal information
(setq user-full-name "your-name"
      user-mail-address "your@gmail.com")

;;; Read POP3 mail
(setq gnus-select-method '(nnml ""))
(setq mail-sources
     '((pop :server "pop.gmail.com"
            :port 995
            :user "your@gmail.com"
            :leave 14
            :stream ssl)))

;;; Sort mail for recent
(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)))

;;; Fold mail by thread
(setq gnus-use-cache t)
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

;;; SMTP options
(setq send-mail-function (quote smtpmail-send-it))
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-auth-credentials (quote (("smtp.gmail.com" 587 "your@gmail.com" nil))))
(setq smtpmail-starttls-credentials (quote (("smtp.gmail.com" 587 nil nil))))

