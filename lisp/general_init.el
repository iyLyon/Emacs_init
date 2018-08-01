;;关闭启动动画
(setq inhibit-startup-message t)
;;关闭出错提示音
(setq ring-bell-function 'ignore)
;;显示列号
(setq column-number-mode t)
;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)
;;菜单栏设置
(menu-bar-mode 0) ;;不显示菜单栏
;;工具栏设置
(tool-bar-mode 0) ;;不显示工具栏 工具栏太丑
;;滚动条设置
(scroll-bar-mode 0) ;;不显示滚动条 太丑
;;识别中文标点
;;(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;;可以递归使用的minibuffer
(setq enable-recursive-minibuffers t)
;;防止页面滚动时跳动
(setq scroll-margin 3
      scroll-conservatively 10000)
;;把缺省的major mode设置为text-mode，而不是什么功能都没有的fundamental-mode
(setq default-major-mode 'text-mode)
;;让光标不闪烁
(blink-cursor-mode 0)
;;让粘贴的内容粘贴到文本光标处，而不是鼠标指针处
(setq mouse-yank-at-point t)
;;显示行号与列号
(global-linum-mode 1)
(column-number-mode 1)
;;不生成备份文件，即 xxx.xx~ 类文件
;;(setq make-backup-files nil)
;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.backups"))))

(provide 'general_init)
