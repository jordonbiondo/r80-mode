                                  (defvar-local r80-previous-indent-line-fn nil)

                                                       (defun r80-indent-line ()
                                                                  (let ((content
                                    (string-trim (buffer-substring-no-properties
                                                       (line-beginning-position)
                                                          (line-end-position))))
                                                          (start (save-excursion
                                           (goto-char (line-beginning-position))
                                                           (back-to-indentation)
                                                                      (point))))
                                                                 (save-excursion
                                                               (goto-char start)
                                 (delete-region (line-beginning-position) start)
                    (insert (make-string (max 0 (- 80 (length content))) ?\s))))
                                                (when (< (point) (save-excursion
                                           (goto-char (line-beginning-position))
                                                 (back-to-indentation) (point)))
                                                         (back-to-indentation)))

                                                       (defun r80-auto-indent ()
                             (unless (= 0 (length (string-trim (buffer-substring
                                                       (line-beginning-position)
                                                         (line-end-position)))))
                                             (ignore-errors (r80-indent-line))))


                                          (define-minor-mode right-align-80-mode
                                                                "Because I can."
                                                                 :init-value nil
                                                                     :global nil
                                                                  :lighter "r80"
                                                         (if right-align-80-mode
                                                                          (progn
                         (setq r80-previous-indent-line-fn indent-line-function)
                                   (setq indent-line-function #'r80-indent-line)
                           (add-hook 'post-command-hook 'r80-auto-indent nil t))
                                                                          (progn
                         (setq indent-line-function r80-previous-indent-line-fn)
                          (remove-hook 'post-command-hook 'r80-auto-indent t))))
