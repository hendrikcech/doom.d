;;; private/rschmukler/+bindings.el -*- lexical-binding: t; -*-



(map!
 ;; Window Movements
 "C-h"    #'evil-window-left
 "C-j"    #'evil-window-down
 "C-k"    #'evil-window-up
 "C-l"    #'evil-window-right


 :nmvo "C-p"    #'counsel-projectile-find-file

 ;; Text-scaling
 "M-+"    (λ! (text-scale-set 0))
 "M-="    #'text-scale-increase
 "M--"    #'text-scale-decrease


 ;; Text Editing
 :nv  "gc"   #'evil-commentary

 (:map evil-window-map ; prefix "C-w"
   ;; Navigation
   "C-h"     #'evil-window-left
   "C-j"     #'evil-window-down
   "C-k"     #'evil-window-up
   "C-l"     #'evil-window-right
   "C-w"     #'ace-window
   ;; Swapping windows
   "H"       #'+evil/window-move-left
   "J"       #'+evil/window-move-down
   "K"       #'+evil/window-move-up
   "L"       #'+evil/window-move-right
   "C-S-w"   #'ace-swap-window
   ;; Window undo/redo
   "u"       #'winner-undo
   "C-u"     #'winner-undo
   "C-r"     #'winner-redo
   "o"       #'doom/window-enlargen
   ;; Delete window
   "c"       #'+workspace/close-window-or-workspace
   "C-C"     #'ace-delete-window)


 ;; Leader Configs
 (:leader
   :desc "M-x"                    :nv ":"   #'execute-extended-command
   :desc "Neotree toggle"         :n  "n"   #'rschmukler/neotree-project-root-dir-or-current-dir

   :desc "Horizonal Split"        :n  "s"   #'split-window-below
   :desc "Vertical Split"         :n  "v"   #'split-window-right

   :desc "Next Error"             :n  "]"   #'flycheck-next-error
   :desc "Previous Error"         :n  "["   #'flycheck-previous-error

   :desc "Find file content"      :n  "f"   #'counsel-projectile-ag
   :desc "Find project"           :n  "p"   #'counsel-projectile-switch-project

   :desc "Eval"                   :n  "e"   #'+eval/buffer
                                  :v  "e"   #'+eval/region

   (:desc "git" :prefix "g"
     :desc "Git status"        :n  "s" #'magit-status
     :desc "Git blame"         :n  "b" #'magit-blame
     :desc "Git time machine"  :n  "t" #'git-timemachine-toggle
     :desc "Git revert hunk"   :n  "r" #'git-gutter:revert-hunk
     :desc "List gists"        :n  "g" #'+gist:list
     :desc "Next hunk"         :nv "]" #'git-gutter:next-hunk
     :desc "Previous hunk"     :nv "[" #'git-gutter:previous-hunk)

   (:desc "open" :prefix "o"
     :desc "Default browser"     :n  "b" #'browse-url-of-file
     :desc "Debugger"            :n  "d" #'+debug/open
     :desc "REPL"                :n  "r" #'+eval/repl
                                 :v  "r" #'+eval:repl
     :desc "Neotree"             :n  "n" #'+neotree/toggle
     :desc "Terminal"            :n  "t" #'+term/popup
     :desc "Terminal in project" :n  "T" #'+term/popup-in-project)

   (:desc "insert" :prefix "i"
     :desc "From kill-ring" :nv "p" #'counsel-yank-pop
     :desc "From snippet"   :nv "s" #'yas-insert-snippet)

   (:desc "workspace" :prefix "TAB"
     :desc "Display tab bar"          :n "TAB" #'+workspace/display
     :desc "New workspace"            :n "n"   #'+workspace/new
     :desc "Load workspace from file" :n "l"   #'+workspace/load
     :desc "Load last session"        :n "L"   (λ! (+workspace/load-session))
     :desc "Save workspace to file"   :n "s"   #'+workspace/save
     :desc "Autosave current session" :n "S"   #'+workspace/save-session
     :desc "Switch workspace"         :n "."   #'+workspace/switch-to
     :desc "Kill all buffers"         :n "x"   #'doom/kill-all-buffers
     :desc "Delete session"           :n "X"   #'+workspace/kill-session
     :desc "Delete this workspace"    :n "d"   #'+workspace/delete
     :desc "Load session"             :n "L"   #'+workspace/load-session
     :desc "Next workspace"           :n "]"   #'+workspace/switch-right
     :desc "Previous workspace"       :n "["   #'+workspace/switch-left
     :desc "Rename workspace"         :n "r"   #'+workspace:rename
     :desc "Switch to 1st workspace"  :n "1"   (λ! (+workspace/switch-to 0))
     :desc "Switch to 2nd workspace"  :n "2"   (λ! (+workspace/switch-to 1))
     :desc "Switch to 3rd workspace"  :n "3"   (λ! (+workspace/switch-to 2))
     :desc "Switch to 4th workspace"  :n "4"   (λ! (+workspace/switch-to 3))
     :desc "Switch to 5th workspace"  :n "5"   (λ! (+workspace/switch-to 4))
     :desc "Switch to 6th workspace"  :n "6"   (λ! (+workspace/switch-to 5))
     :desc "Switch to 7th workspace"  :n "7"   (λ! (+workspace/switch-to 6))
     :desc "Switch to 8th workspace"  :n "8"   (λ! (+workspace/switch-to 7))
     :desc "Switch to 9th workspace"  :n "9"   (λ! (+workspace/switch-to 8))
     :desc "Switch to last workspace" :n "0"   #'+workspace/switch-to-last)

   )

 ;; ivy
 (:after ivy
   :map ivy-minibuffer-map
   [escape] #'keyboard-escape-quit
   "M-v" #'yank
   "M-z" #'undo
   "C-r" #'evil-paste-from-register
   "C-k" #'ivy-previous-line
   "C-j" #'ivy-next-line
   "C-l" #'ivy-alt-done
   "C-w" #'ivy-backward-kill-word
   "C-u" #'ivy-kill-line
   "C-b" #'backward-word
   "C-f" #'forward-word)

 ;; neotree
 (:after neotree
   :map neotree-mode-map
   :n "g"         nil
   :n [tab]       #'neotree-quick-look
   :n "RET"       #'neotree-enter
   :n [backspace] #'evil-window-prev
   :n "c"         #'neotree-create-node
   :n "j"         #'neotree-next-line
   :n "k"         #'neotree-previous-line
   :n "n"         #'neotree-next-line
   :n "p"         #'neotree-previous-line
   :n "h"         #'+neotree/collapse-or-up
   :n "l"         #'+neotree/expand-or-open
   :n "J"         #'neotree-select-next-sibling-node
   :n "K"         #'neotree-select-previous-sibling-node
   :n "H"         #'neotree-select-up-node
   :n "L"         #'neotree-select-down-node
   :n "G"         #'evil-goto-line
   :n "gg"        #'evil-goto-first-line
   :n "v"         #'neotree-enter-vertical-split
   :n "s"         #'neotree-enter-horizontal-split
   :n "q"         #'neotree-hide
   :n "R"         #'neotree-refresh)

 ;; company
 (:after company
   :map company-active-map
   "C-j"         #'company-select-next
   "C-k"         #'company-select-previous
   )

 ;; counsel
 (:after counsel
   (:map ivy-mode-map
     "C-o"      #'ivy-dispatching-done)
   (:map counsel-ag-map
     [backtab]  #'+ivy/wgrep-occur  ; search/replace on results
     "C-SPC"    #'counsel-git-grep-recenter   ; preview
     "M-RET"    (+ivy-do-action! #'+ivy-git-grep-other-window-action)))
)


;; This section is dedicated to "fixing" certain keys so that they behave
;; properly, more like vim. Ripped directly from hlissner
(map! (:map input-decode-map
        [?\C-i] [C-i]
        [S-iso-lefttab] [backtab]
        (:unless window-system "TAB" [tab])) ; Fix TAB in terminal

      ;; I want C-a and C-e to be a little smarter. C-a will jump to
      ;; indentation. Pressing it again will send you to the true bol. Same goes
      ;; for C-e, except it will ignore comments and trailing whitespace before
      ;; jumping to eol.
      :i "C-a" #'doom/backward-to-bol-or-indent
      :i "C-e" #'doom/forward-to-last-non-comment-or-eol
      :i "C-u" #'doom/backward-kill-to-bol-and-indent

      ;; textmate-esque newline insertion
      :i [M-return]     #'evil-open-below
      :i [S-M-return]   #'evil-open-above
      ;; textmate-esque deletion
      [M-backspace]     #'doom/backward-kill-to-bol-and-indent
      :i [backspace]    #'delete-backward-char
      :i [M-backspace]  #'doom/backward-kill-to-bol-and-indent
      ;; Emacsien motions for insert mode
      :i "C-b" #'backward-word
      :i "C-f" #'forward-word

      ;; Highjacks space/backspace to:
      ;;   a) balance spaces inside brackets/parentheses ( | ) -> (|)
      ;;   b) delete space-indented blocks intelligently
      ;;   c) do none of this when inside a string
      :i "SPC"                          #'doom/inflate-space-maybe
      :i [remap delete-backward-char]   #'doom/deflate-space-maybe
      :i [remap newline]                #'doom/newline-and-indent

      (:after org-mode
        (:map org-mode-map
          :i [remap doom/inflate-space-maybe] #'org-self-insert-command))

      ;; Make ESC quit all the things
      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map)
        [escape] #'abort-recursive-edit
        "C-r" #'evil-paste-from-register)

      (:map messages-buffer-mode-map
        "M-;" #'eval-expression
        "A-;" #'eval-expression)

      (:map tabulated-list-mode-map
        [remap evil-record-macro] #'doom/popup-close-maybe)

      (:map (evil-ex-completion-map evil-ex-search-keymap read-expression-map)
        "C-a" #'move-beginning-of-line
        "C-w" #'doom/minibuffer-kill-word
        "C-u" #'doom/minibuffer-kill-line
        "C-b" #'backward-word
        "C-f" #'forward-word
        "M-z" #'doom/minibuffer-undo)

      (:after view
        (:map view-mode-map "<escape>" #'View-quit-all)))