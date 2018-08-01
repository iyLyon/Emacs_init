;;包管理工具，自带
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")                          ("gnu" . "http://elpa.gnu.org/packages/"))
      package-enable-at-startup nil)
(package-initialize)

;;安装use-package包，解决package,el功能的局限性：包重复安装和配置漂移的麻烦
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;这里是emacs自动下载的东西，暂时只知道是package-install的原因
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;加载theme
(load-theme 'molokai t)
;;启用ido,对新手很实用的一个功能，emacs自带,也可使用功能更强的helm，在下面配置了
(ido-mode 1)
;;文件/.emacs.d/lisp中存放了用户自定义的模块文件


;;;;;;;;;;;;;;;;;;;;;;;;;lisp文件夹下的配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;加载基础配置
(require 'general_init)




;;;;;;;;;;;;;;;;;;;;;;;;;elpa文件夹下的配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex));;

(use-package youdao-dictionary
  :ensure t
  :init
  (setq url-automatic-caching t)
  :config
  (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+))

;;helm配置
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;;YASnippet:自动扩展模板，方便写一些固定的东西
;;Add your own snippets to ~/.emacs.d/snippets by placing files there or invoking yas-new-snippet.
(require 'yasnippet)
(yas-global-mode 1)

;;electric-mode是辅助自动插入成对括号的工具
(electric-pair-mode 1)
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            ) )

;;Flycheck是语法检查工具
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;ace-jump-mode是可以快速跳转的一个工具
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;Projectile 用于查看工程项目里的文件
(require 'projectile)
;; 默认全局使用
(projectile-global-mode)
;; 默认打开缓存
(setq projectile-enable-caching t)
;; 使用f5键打开默认文件搜索
(global-set-key [f5] 'projectile-find-file)

;;wakatime-mode为代码量统计工具
;;(load "~/.emac.d/elpa/wakatime-mode-20170518.353")
;;设定wakatime api key
(custom-set-variables '(wakatime-api-key "e86d2fcb-7a10-408c-ab87-ac2a17c2519ax"))
(custom-set-variables '(wakatime-cli-path "/usr/local/bin/wakatime"))
;;全局开启wakatime-mode
(global-wakatime-mode 1)


;;irony-mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;company-mode
(add-hook 'after-init-hook 'global-company-mode)
(autoload 'company-mode "company" nil t)
;;;end
