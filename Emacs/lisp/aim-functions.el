;; OS X doesn't use the shell PATH if it's not started from the shell.
(defun aim/set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
	 (replace-regexp-in-string "[[:space:]\n]*$" ""
				   (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(defun aim/load-file-if-exists (filename)
  (interactive)
  (and (file-exists-p filename)
     (load-file filename)))

(defun aim/reverse-video nil
  "*Invert default face"
  (interactive)
  (let* ((fg (face-foreground 'default))
	 (bg (face-background 'default)))
    (set-face-foreground 'default bg)
    (set-face-background 'default fg)))

(defun aim/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun aim/revert-buffer-now ()
  "revert-(current-buffer) asking no questions"
  (interactive)
  (revert-buffer nil t))

(defun aim/check-frame-colours ()
  (interactive)
  (and window-system
       (if (string-equal (downcase (face-foreground 'default)) "black")
	   (aim/reverse-video))))

(defun aim/require (FEATURE &optional FILENAME NOERROR)
  (interactive)
  (message "Loading %S" FEATURE)
  (let ((res (require FEATURE FILENAME NOERROR)))
    (and res (message "Success!"))
    res))

(provide 'aim-functions)
