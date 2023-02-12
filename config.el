;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :leader
      :desc"Comment or Uncomment"
      "cl" #'evilnc-comment-or-uncomment-lines)
;; 虚拟终端
(map! :leader
      :desc"Open vterm Here"
      ";" #'+vterm/here)
(map! :leader
      :desc"dired"
      "d" #'dired)
;; 创建正则匹配的buffer
(map! :leader
      :desc"occur"
      "sc" #'occur)
(after! org
        (add-to-list 'org-latex-default-packages-alist '("" "ctex" t ("xelatex")))

        (add-to-list 'org-preview-latex-process-alist '(dvisvgm :programs ("xelatex" "dvisvgm")
                                                                :discription "xdv > svg"
                                                                :message "you need install the programs: xelatex and dvisvgm."
                                                                :image-input-type "xdv"
                                                                :image-output-type "svg"
                                                                :image-size-adjust (1.7 . 1.5)
                                                                :latex-compiler ("xelatex -interaction nonstopmode -no-pdf -output-directory %o %f")
                                                                :image-converter ("dvisvgm %f -e -n -b min -c %S -o %O")))
                                                                ;; :image-converter ("dvisvgm %f -n -b min -c %S -o %O")))
         (use-package! org-fragtog
           :hook (org-mode . org-fragtog-mode))
)
;; (add-hook 'org-mode-hook 'lsp-org)
(setq display-line-numbers-type 'relative)
;; (setq org-latex-create-formula-image-program 'dvipng)
(setq org-preview-latex-image-directory "~/ltximg/")
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-latex-compiler "xelatex")
;; (setq org-latex-pdf-process '("xelatex %f"))
(add-hook 'org-mode-hook
          (lambda()
            (define-key evil-insert-state-local-map (kbd "<S-return>") 'evil-org-open-below)))
(add-hook 'org-mode-hook
          (lambda()
                (map! :leader
                :desc"latex previewer"
                "np" #'org-latex-preview)
                ))
(add-hook 'org-mode-hook
          (lambda()
                (map! :leader
                :desc"lsp"
                "l" #'lsp-org)
                ))
;; (after! tramp
;;   (setq tramp-verbose 10)
;;   )
(setq url-proxy-services
      '(("https"     . "127.0.0.1:7890")
        ("http"     . "127.0.0.1:7890")))
;; (setq url-http-proxy-basic-auth-storage
;;     (list (list "http://127.0.0.1:7890"
;;                 (cons "Input your LDAP UID !"
;;                       (base64-encode-string "login:lvyuanzhou")))))
