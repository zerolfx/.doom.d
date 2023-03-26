;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "zerol"
      user-mail-address "zerolfx0@gmail.com")

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
(setq! line-spacing 0)
(setq! zl/font-size
       (if (= (display-pixel-height) 2160) 27 15))

(setq! doom-font (font-spec :family "JetBrains Mono" :size zl/font-size :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "Noto Sans CJK SC" :size zl/font-size)
       doom-unicode-font (font-spec :family "Noto Sans Mono CJK SC" :size zl/font-size))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'gruvbox-dark-medium)

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

; decrease wait time after SPC
(setq which-key-idle-delay 0.4)

(use-package! evil-terminal-cursor-changer
  :config
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)
    ))


;; copilot configuraton
(use-package! copilot
  :after company
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         ("C-!" . 'copilot-next-completion)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion))
  :config
  (setq! global-copilot-mode t)
  (setq! copilot-idle-delay 0.1)
  (setq! copilot-log-max nil))

; migrate from spacemacs
(map! :leader "0" 'treemacs-select-window
      :leader "1" 'winum-select-window-1
      :leader "2" 'winum-select-window-2
      :leader "3" 'winum-select-window-3
      :leader "4" 'winum-select-window-4
      :leader "5" 'winum-select-window-5
      :leader "6" 'winum-select-window-6
      :leader "7" 'winum-select-window-7)
(map! :leader "f t" 'treemacs)
(map! :leader "w /" 'split-window-horizontally)


; make modeline smaller
(after! doom-modeline
  (setq doom-modeline-height 0.1)
  (set-face-attribute 'mode-line nil
                  :family "DejaVu Sans Mono"
                  :height 0.9)
  (set-face-attribute 'mode-line-inactive nil
                  :family "DejaVu Sans Mono"
                  :height 0.9))
; fix modeline overflow
(after! all-the-icons
  (setq all-the-icons-scale-factor 1.1))

; ace jump
(setq avy-all-windows t)
(map! :leader "j l" 'avy-goto-line
      :leader "j j" 'avy-goto-char-timer)

; maximize window on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; show icons in treemacs
(setq doom-themes-treemacs-theme "doom-colors")

; latex
(after! tex
  (setq-default TeX-engine 'xetex)
  (add-to-list 'TeX-view-program-selection '(output-pdf "Okular"))
  (setq-default TeX-command-extra-options "-shell-escape"))

; add code syntax highlighting in markdown
(after! markdown-mode
  (setq markdown-fontify-code-blocks-natively t))

(after! winum
  (add-to-list 'winum-ignored-buffers "*sort-tab*"))

(setq! shell-file-name "/bin/fish")
(setenv "SHELL" shell-file-name)


(add-hook! emacs-lisp-mode (setq-local tab-width 2))

; lsp
(after! lsp-mode
  (setq! lsp-haskell-formatting-provider "brittany"))

;; semantic highlighting
(after! lsp-mode
  (setq! lsp-semantic-tokens-apply-modifiers nil)
  (setq! lsp-semantic-tokens-enable t))


;; centaur tabs
(after! centaur-tabs
  ;; (setq! centaur-tabs-height 20)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-headline-match)
  (centaur-tabs-enable-buffer-reordering)
  (map! :n "S-<left>" 'centaur-tabs-backward
        :n "S-<right>" 'centaur-tabs-forward)
  )


(map! :n "] e" #'flycheck-next-error
      :n "[ e" #'flycheck-previous-error)

;; enable clang-tidy
(setq! lsp-clients-clangd-args
       '("-j=4"
         "--background-index"
         "--clang-tidy"
         "--completion-style=bundled"
         "--pch-storage=memory"
         "--header-insertion=never"
         "--header-insertion-decorators=0"))
