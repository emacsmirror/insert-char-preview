;;; insert-char-preview.el --- Insert Unicode char -*- lexical-binding: t -*-

;; Author: Matsievskiy S.V.
;; Maintainer: Matsievskiy S.V.
;; Version: 0.1
;; Package-Requires: ((emacs "24.1") (ht "2.2"))
;; Homepage: https://gitlab.com/matsievskiysv/insert-char-preview
;; Keywords: convenience


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; Insert Unicode char similar to `insert-char` command, but with
;; character preview in completion prompt.

;;; Code:

(require 'ht)

(defcustom insert-char-preview-format "%x(%s) %s"
  "Format string.  Arguments are: number, char, name."
  :tag  "Preview format"
  :type 'string)

(setq insert-char-preview--table
      (let ((h (ht-create)))
        (maphash (lambda (k v)
                   (ht-set h (format insert-char-preview-format
                                     v (string v) k)
                           v))
                 (ucs-names))
        h))

(defun insert-char-preview (COUNT CHARACTER)
  "Insert COUNT copies of CHARACTER.
Similar to `insert-char` in interactive mode, but with char preview."
  (interactive (list current-prefix-arg
                     (completing-read "Insert character: "
                                      insert-char-preview--table)))
  (insert-char (ht-get insert-char-preview--table CHARACTER "?") COUNT))

(provide 'insert-char-preview)

;;; insert-char-preview.el ends here
