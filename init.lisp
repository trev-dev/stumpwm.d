(init-load-path (merge-pathnames *data-dir* "contrib"))
(in-package :stumpwm)
(load-module :screenshot)

(set-prefix-key (kbd "s-p"))

;;; Theme
(setf *colors*
      '("#191919"   ;black
        "#FF7B85"   ;red
        "#ABDC88"   ;green
        "#FFCA41"   ;yellow
        "#82AAFF"   ;blue
        "#C792EA"   ;magenta
        "#89DDFF"   ;cyan
        "#BFC7D5")) ;white

(update-color-map (current-screen))

(setf *default-bg-color* (car *colors*)
      *mouse-focus-policy* :click
      *window-border-style* :thin
      *mode-line-background-color* (car *colors*)
      *mode-line-foreground-color* (car (last *colors*))
      *ignore-wm-inc-hints* t)

(defcommand kitty () ()
            (run-shell-command "kitty"))

(defcommand firefox () ()
            (run-shell-command "firefox"))

(defcommand display-laptop () ()
  (run-shell-command (concat "xrandr --output eDP-1 "
                             "--primary --mode 1920x1080 "
                             "--pos 0x0 --rotate normal "
                             "--output DP-1 --off --output HDMI-1 "
                             "--off --output DP-2 "
                             "--off --output HDMI-2 --off")))

(defcommand display-dualmonitor () ()
  (run-shell-command (concat "xrandr --output eDP-1 "
                             "--mode 1920x1080 --pos 1920x0 "
                             "--rotate normal --output DP-1 --off "
                             "--output HDMI-1 --primary --mode 1920x1080 "
                             "--pos 0x0 --rotate normal --output DP-2 --off "
                             "--output HDMI-2 --off")))

(defcommand xsecurelock () ()
            (run-shell-command "xsecurelock"))

(setf *which-key-format* "^5*~5a^n ~a")

(define-key *root-map* (kbd "t") "kitty")
(define-key *root-map* (kbd "C-l") "xsecurelock")
(define-key *root-map* (kbd "b") "firefox")

(setf *time-modeline-string* "%a, %b %d %H:%M")
(setf *screen-mode-line-format* "[%n] %W ^> %d")

;; Monitor backlight
(let ((bdown   "exec light -U 5")
      (bup     "exec light -A 5")
      (m *top-map*))
  (define-key m (kbd "s-C-s")                 bdown)
  (define-key m (kbd "XF86MonBrightnessDown") bdown)
  (define-key m (kbd "s-C-d")                 bup)
  (define-key m (kbd "XF86MonBrightnessUp")   bup))

;; Slynk for emacs/repl support
(asdf:load-system :slynk)

(defcommand slynk-start () ()
  (slynk:create-server :port 4008))

(defcommand slynk-stop () ()
  (slynk:stop-server 4008))

(defcommand slynk-restart () ()
  (slynk:restart-server :port 4008))

; (asdf:load-system :pamixer)

; (define-key *top-map* (kbd "XF86AudioRaiseVolume") "pamixer-volume-up")
; (define-key *top-map* (kbd "XF86AudioLowerVolume") "pamixer-volume-down")
; (define-key *top-map* (kbd "XF86AudioMute") "pamixer-toggle-mute")

;; Auto starts

(load-module :notify)
(setf notify:*notify-server-title-color* "^B^3")
(setf notify:*notify-server-body-color* "^7*")

(notify:notify-server-toggle)
(run-shell-command "setxkbmap -option caps:escape")
(run-shell-command
 "feh --bg-fill ~/Pictures/wallpapers/aaron-burden-ice-bubble.jpg")
