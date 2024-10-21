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

(defmacro with-window ((width height title) &body body)
 `(progn (init-window ,width ,height ,title)
         (unwind-protect (progn ,@body)
          (close-window))))

(defmacro with-drawing (&body body)
 `(progn (begin-drawing)
         (unwind-protect (progn ,@body)
          (end-drawing))))

(defmacro with-mode-2d ((camera) &body body)
 `(progn (begin-mode-2d ,camera)
         (unwind-protect (progn ,@body)
          (end-mode-2d))))

(defmacro with-mode-3d ((camera) &body body)
 `(progn (begin-mode-3d ,camera)
         (unwind-protect (progn ,@body)
          (end-mode-3d))))

(defmacro with-texture-mode ((target) &body body)
 `(progn (begin-texture-mode ,target)
         (unwind-protect (progn ,@body)
          (end-texture-mode))))

(defmacro with-shader-mode ((shader) &body body)
 `(progn (begin-shader-mode ,shader)
         (unwind-protect (progn ,@body)
          (end-shader-mode))))

(defmacro with-blend-mode ((mode) &body body)
 `(progn (begin-blend-mode ,mode)
         (unwind-protect (progn ,@body)
          (end-blend-mode))))

(defmacro with-audio-device (&body body)
 `(progn (init-audio-device)
         (unwind-protect (progn ,@body)
           (close-audio-device))))

(defmacro with-audio-stream ((stream sample-rate sample-size channels) &body body)
 `(let ((,stream (load-audio-stream ,sample-rate ,sample-size ,channels)))
    (unwind-protect (progn ,@body)
      (unload-audio-stream ,stream))))

(defmacro with-sound ((sound file-name) &body body)
  `(let ((,sound (load-sound ,file-name)))
     (unwind-protect (progn ,@body)
       (unload-sound ,sound))))
