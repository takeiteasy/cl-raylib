;; MIT License

;; Copyright (c) longlene 2017

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

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
