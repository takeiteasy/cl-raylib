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

