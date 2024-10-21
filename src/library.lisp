(in-package #:cl-raylib)

(pushnew (asdf:system-relative-pathname :cl-raylib #p"build/")
         cffi:*foreign-library-directories*
         :test #'equal)

(define-foreign-library libraylib
  (:darwin "libraylib.dylib")
  (:unix "libraylib.so")
  (:windows (:or "raylib.dll" "libraylib.dll"))
  (t (:default "libraylib")))

(unless (foreign-library-loaded-p 'libraylib)
  (use-foreign-library libraylib))

(in-package #:cl-raygui)

(define-foreign-library libraygui
  (:darwin "libraygui.dylib")
  (:unix "libraygui.so")
  (:windows (:or "raygui.dll" "libraygui.dll"))
  (t (:default "libraygui")))

(unless (foreign-library-loaded-p 'libraygui)
  (use-foreign-library libraygui))
