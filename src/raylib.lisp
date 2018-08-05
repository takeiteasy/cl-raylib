(in-package #:cl-raylib)
;;;/**********************************************************************************************
;;;*
;;;*   raylib - A simple and easy-to-use library to learn videogames programming (www.raylib.com)
;;;*
;;;*   FEATURES:
;;;*       - NO external dependencies, all required libraries included with raylib
;;;*       - Multiple platforms support: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly, MacOS, UWP, Android, Raspberry Pi, HTML5.
;;;*       - Written in plain C code (C99) in PascalCase/camelCase notation
;;;*       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES2 - choose at compile)
;;;*       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
;;;*       - Powerful fonts module with Fonts support (XNA fonts, AngelCode fonts, TTF)
;;;*       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
;;;*       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
;;;*       - Flexible Materials system, supporting classic maps and PBR maps
;;;*       - Shaders support, including Model shaders and Postprocessing shaders
;;;*       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
;;;*       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
;;;*       - VR stereo rendering with configurable HMD device parameters
;;;*       - Complete bindings to LUA (raylib-lua) and Go (raylib-go)
;;;*
;;;*   NOTES:
;;;*       One custom font is loaded by default when InitWindow() [core]
;;;*       If using OpenGL 3.3 or ES2, one default shader is loaded automatically (internally defined) [rlgl]
;;;*       If using OpenGL 3.3 or ES2, several vertex buffers (VAO/VBO) are created to manage lines-triangles-quads
;;;*
;;;*   DEPENDENCIES (included):
;;;*       rglfw (github.com/glfw/glfw) for window/context management and input (only PLATFORM_DESKTOP) [core]
;;;*       glad (github.com/Dav1dde/glad) for OpenGL extensions loading (3.3 Core profile, only PLATFORM_DESKTOP) [rlgl]
;;;*       mini_al (github.com/dr-soft/mini_al) for audio device/context management [audio]
;;;*
;;;*   OPTIONAL DEPENDENCIES (included):
;;;*       stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...) [textures]
;;;*       stb_image_resize (Sean Barret) for image resizing algorythms [textures]
;;;*       stb_image_write (Sean Barret) for image writting (PNG) [utils]
;;;*       stb_truetype (Sean Barret) for ttf fonts loading [text]
;;;*       stb_rect_pack (Sean Barret) for rectangles packing [text]
;;;*       stb_vorbis (Sean Barret) for OGG audio loading [audio]
;;;*       stb_perlin (Sean Barret) for Perlin noise image generation [textures]
;;;*       par_shapes (Philip Rideout) for parametric 3d shapes generation [models]
;;;*       jar_xm (Joshua Reisenauer) for XM audio module loading [audio]
;;;*       jar_mod (Joshua Reisenauer) for MOD audio module loading [audio]
;;;*       dr_flac (David Reid) for FLAC audio file loading [audio]
;;;*       dr_mp3 (David Reid) for MP3 audio file loading [audio]
;;;*       rgif (Charlie Tangora, Ramon Santamaria) for GIF recording [core]
;;;*
;;;*
;;;*   LICENSE: zlib/libpng
;;;*
;;;*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
;;;*   BSD-like license that allows static linking with closed source software:
;;;*
;;;*   Copyright (c) 2013-2018 Ramon Santamaria (@raysan5)
;;;*
;;;*   This software is provided "as-is", without any express or implied warranty. In no event
;;;*   will the authors be held liable for any damages arising from the use of this software.
;;;*
;;;*   Permission is granted to anyone to use this software for any purpose, including commercial
;;;*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
;;;*
;;;*     1. The origin of this software must not be misrepresented; you must not claim that you
;;;*     wrote the original software. If you use this software in a product, an acknowledgment
;;;*     in the product documentation would be appreciated but is not required.
;;;*
;;;*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
;;;*     as being the original software.
;;;*
;;;*     3. This notice may not be removed or altered from any source distribution.
;;;*
;;;**********************************************************************************************/

;;#ifndef RAYLIB_H
;;#define RAYLIB_H
;;
;;#if defined(_WIN32) && defined(BUILD_LIBTYPE_SHARED)
;;    #define RLAPI __declspec(dllexport)         // We are building raylib as a Win32 shared library (.dll)
;;#elif defined(_WIN32) && defined(USE_LIBTYPE_SHARED)
;;    #define RLAPI __declspec(dllimport)         // We are using raylib as a Win32 shared library (.dll)
;;#else
;;    #define RLAPI   // We are building or using raylib as a static library (or Linux shared library)
;;#endif
;;
;;//----------------------------------------------------------------------------------
;;// Some basic Defines
;;//----------------------------------------------------------------------------------
;;#ifndef PI
;;    #define PI 3.14159265358979323846f
;;#endif
;;
;;#define DEG2RAD (PI/180.0f)
;;#define RAD2DEG (180.0f/PI)
;;
;;// raylib Config Flags
;;#define FLAG_SHOW_LOGO              1       // Set to show raylib logo at startup
;;#define FLAG_FULLSCREEN_MODE        2       // Set to run program in fullscreen
;;#define FLAG_WINDOW_RESIZABLE       4       // Set to allow resizable window
;;#define FLAG_WINDOW_UNDECORATED     8       // Set to disable window decoration (frame and buttons)
;;#define FLAG_WINDOW_TRANSPARENT    16       // Set to allow transparent window
;;#define FLAG_MSAA_4X_HINT          32       // Set to try enabling MSAA 4X
;;#define FLAG_VSYNC_HINT            64       // Set to try enabling V-Sync on GPU
;;
;;// Keyboard Function Keys
;;#define KEY_SPACE            32
;;#define KEY_ESCAPE          256
;;#define KEY_ENTER           257
;;#define KEY_TAB             258
;;#define KEY_BACKSPACE       259
;;#define KEY_INSERT          260
;;#define KEY_DELETE          261
;;#define KEY_RIGHT           262
;;#define KEY_LEFT            263
;;#define KEY_DOWN            264
;;#define KEY_UP              265
;;#define KEY_PAGE_UP         266
;;#define KEY_PAGE_DOWN       267
;;#define KEY_HOME            268
;;#define KEY_END             269
;;#define KEY_CAPS_LOCK       280
;;#define KEY_SCROLL_LOCK     281
;;#define KEY_NUM_LOCK        282
;;#define KEY_PRINT_SCREEN    283
;;#define KEY_PAUSE           284
;;#define KEY_F1              290
;;#define KEY_F2              291
;;#define KEY_F3              292
;;#define KEY_F4              293
;;#define KEY_F5              294
;;#define KEY_F6              295
;;#define KEY_F7              296
;;#define KEY_F8              297
;;#define KEY_F9              298
;;#define KEY_F10             299
;;#define KEY_F11             300
;;#define KEY_F12             301
;;#define KEY_LEFT_SHIFT      340
;;#define KEY_LEFT_CONTROL    341
;;#define KEY_LEFT_ALT        342
;;#define KEY_RIGHT_SHIFT     344
;;#define KEY_RIGHT_CONTROL   345
;;#define KEY_RIGHT_ALT       346
;;#define KEY_GRAVE            96
;;#define KEY_SLASH            47
;;#define KEY_BACKSLASH        92
;;
;;// Keyboard Alpha Numeric Keys
;;#define KEY_ZERO             48
;;#define KEY_ONE              49
;;#define KEY_TWO              50
;;#define KEY_THREE            51
;;#define KEY_FOUR             52
;;#define KEY_FIVE             53
;;#define KEY_SIX              54
;;#define KEY_SEVEN            55
;;#define KEY_EIGHT            56
;;#define KEY_NINE             57
;;#define KEY_A                65
;;#define KEY_B                66
;;#define KEY_C                67
;;#define KEY_D                68
;;#define KEY_E                69
;;#define KEY_F                70
;;#define KEY_G                71
;;#define KEY_H                72
;;#define KEY_I                73
;;#define KEY_J                74
;;#define KEY_K                75
;;#define KEY_L                76
;;#define KEY_M                77
;;#define KEY_N                78
;;#define KEY_O                79
;;#define KEY_P                80
;;#define KEY_Q                81
;;#define KEY_R                82
;;#define KEY_S                83
;;#define KEY_T                84
;;#define KEY_U                85
;;#define KEY_V                86
;;#define KEY_W                87
;;#define KEY_X                88
;;#define KEY_Y                89
;;#define KEY_Z                90
;;
;;// Android Physical Buttons
;;#define KEY_BACK              4
;;#define KEY_MENU             82
;;#define KEY_VOLUME_UP        24
;;#define KEY_VOLUME_DOWN      25
;;
;;// Mouse Buttons
;;#define MOUSE_LEFT_BUTTON     0
;;#define MOUSE_RIGHT_BUTTON    1
;;#define MOUSE_MIDDLE_BUTTON   2
;;
;;// Touch points registered
;;#define MAX_TOUCH_POINTS      2
;;
;;// Gamepad Number
;;#define GAMEPAD_PLAYER1       0
;;#define GAMEPAD_PLAYER2       1
;;#define GAMEPAD_PLAYER3       2
;;#define GAMEPAD_PLAYER4       3
;;
;;// Gamepad Buttons/Axis
;;
;;// PS3 USB Controller Buttons
;;#define GAMEPAD_PS3_BUTTON_TRIANGLE 0
;;#define GAMEPAD_PS3_BUTTON_CIRCLE   1
;;#define GAMEPAD_PS3_BUTTON_CROSS    2
;;#define GAMEPAD_PS3_BUTTON_SQUARE   3
;;#define GAMEPAD_PS3_BUTTON_L1       6
;;#define GAMEPAD_PS3_BUTTON_R1       7
;;#define GAMEPAD_PS3_BUTTON_L2       4
;;#define GAMEPAD_PS3_BUTTON_R2       5
;;#define GAMEPAD_PS3_BUTTON_START    8
;;#define GAMEPAD_PS3_BUTTON_SELECT   9
;;#define GAMEPAD_PS3_BUTTON_UP      24
;;#define GAMEPAD_PS3_BUTTON_RIGHT   25
;;#define GAMEPAD_PS3_BUTTON_DOWN    26
;;#define GAMEPAD_PS3_BUTTON_LEFT    27
;;#define GAMEPAD_PS3_BUTTON_PS      12
;;
;;// PS3 USB Controller Axis
;;#define GAMEPAD_PS3_AXIS_LEFT_X     0
;;#define GAMEPAD_PS3_AXIS_LEFT_Y     1
;;#define GAMEPAD_PS3_AXIS_RIGHT_X    2
;;#define GAMEPAD_PS3_AXIS_RIGHT_Y    5
;;#define GAMEPAD_PS3_AXIS_L2         3       // [1..-1] (pressure-level)
;;#define GAMEPAD_PS3_AXIS_R2         4       // [1..-1] (pressure-level)
;;
;;// Xbox360 USB Controller Buttons
;;#define GAMEPAD_XBOX_BUTTON_A       0
;;#define GAMEPAD_XBOX_BUTTON_B       1
;;#define GAMEPAD_XBOX_BUTTON_X       2
;;#define GAMEPAD_XBOX_BUTTON_Y       3
;;#define GAMEPAD_XBOX_BUTTON_LB      4
;;#define GAMEPAD_XBOX_BUTTON_RB      5
;;#define GAMEPAD_XBOX_BUTTON_SELECT  6
;;#define GAMEPAD_XBOX_BUTTON_START   7
;;#define GAMEPAD_XBOX_BUTTON_UP      10
;;#define GAMEPAD_XBOX_BUTTON_RIGHT   11
;;#define GAMEPAD_XBOX_BUTTON_DOWN    12
;;#define GAMEPAD_XBOX_BUTTON_LEFT    13
;;#define GAMEPAD_XBOX_BUTTON_HOME    8
;;
;;// Android Gamepad Controller (SNES CLASSIC)
;;#define GAMEPAD_ANDROID_DPAD_UP        19
;;#define GAMEPAD_ANDROID_DPAD_DOWN      20
;;#define GAMEPAD_ANDROID_DPAD_LEFT      21
;;#define GAMEPAD_ANDROID_DPAD_RIGHT     22
;;#define GAMEPAD_ANDROID_DPAD_CENTER    23
;;
;;#define GAMEPAD_ANDROID_BUTTON_A       96
;;#define GAMEPAD_ANDROID_BUTTON_B       97
;;#define GAMEPAD_ANDROID_BUTTON_C       98
;;#define GAMEPAD_ANDROID_BUTTON_X       99
;;#define GAMEPAD_ANDROID_BUTTON_Y       100
;;#define GAMEPAD_ANDROID_BUTTON_Z       101
;;#define GAMEPAD_ANDROID_BUTTON_L1      102
;;#define GAMEPAD_ANDROID_BUTTON_R1      103
;;#define GAMEPAD_ANDROID_BUTTON_L2      104
;;#define GAMEPAD_ANDROID_BUTTON_R2      105
;;
;;// Xbox360 USB Controller Axis
;;// NOTE: For Raspberry Pi, axis must be reconfigured
;;#if defined(PLATFORM_RPI)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_X    0   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_Y    1   // [-1..1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_X   3   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_Y   4   // [-1..1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_LT        2   // [-1..1] (pressure-level)
;;    #define GAMEPAD_XBOX_AXIS_RT        5   // [-1..1] (pressure-level)
;;#else
;;    #define GAMEPAD_XBOX_AXIS_LEFT_X    0   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_Y    1   // [1..-1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_X   2   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_Y   3   // [1..-1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_LT        4   // [-1..1] (pressure-level)
;;    #define GAMEPAD_XBOX_AXIS_RT        5   // [-1..1] (pressure-level)
;;#endif
;;
;;// NOTE: MSC C++ compiler does not support compound literals (C99 feature)
;;// Plain structures in C++ (without constructors) can be initialized from { } initializers.
;;#ifdef __cplusplus
;;    #define CLITERAL
;;#else
;;    #define CLITERAL    (Color)
;;#endif
;;
;;// Some Basic Colors
;;// NOTE: Custom raylib color palette for amazing visuals on WHITE background
;;#define LIGHTGRAY  CLITERAL{ 200, 200, 200, 255 }   // Light Gray
(define-constant +lightgray+ '(200 200 200 255) :test #'equal)
;;#define GRAY       CLITERAL{ 130, 130, 130, 255 }   // Gray
(define-constant +gray+ '(130 130 130 255) :test #'equal)
;;#define DARKGRAY   CLITERAL{ 80, 80, 80, 255 }      // Dark Gray
(define-constant +darkgray+ '(80 80 80 255) :test #'equal)
;;#define YELLOW     CLITERAL{ 253, 249, 0, 255 }     // Yellow
(define-constant +yellow+ '(253 249 0 255) :test #'equal)
;;#define GOLD       CLITERAL{ 255, 203, 0, 255 }     // Gold
(define-constant +gold+ '(255 203 0 255) :test #'equal)
;;#define ORANGE     CLITERAL{ 255, 161, 0, 255 }     // Orange
(define-constant +orange+     '(255 161 0 255 ) :test #'equal)
;;#define PINK       CLITERAL{ 255, 109, 194, 255 }   // Pink
(define-constant +pink+       '(255 109 194 255) :test #'equal)
;;#define RED        CLITERAL{ 230, 41, 55, 255 }     // Red
(define-constant +red+        '( 230 41 55 255 ) :test #'equal)     
;;#define MAROON     CLITERAL{ 190, 33, 55, 255 }     // Maroon
(define-constant +maroon+      '(190 33 55 255) :test #'equal) 
;;#define GREEN      CLITERAL{ 0, 228, 48, 255 }      // Green
(define-constant +green+       '(0 228 48 255) :test #'equal) 
;;#define LIME       CLITERAL{ 0, 158, 47, 255 }      // Lime
(define-constant +lime+        '(0 158 47 255) :test #'equal) 
;;#define DARKGREEN  CLITERAL{ 0, 117, 44, 255 }      // Dark Green
(define-constant +darkgreen+   '(0 117 44 255) :test #'equal) 
;;#define SKYBLUE    CLITERAL{ 102, 191, 255, 255 }   // Sky Blue
(define-constant +skyblue+     '(102 191 255 255) :test #'equal) 
;;#define BLUE       CLITERAL{ 0, 121, 241, 255 }     // Blue
(define-constant +blue+        '(0 121 241 255) :test #'equal) 
;;#define DARKBLUE   CLITERAL{ 0, 82, 172, 255 }      // Dark Blue
(define-constant +darkblue+    '(0 82 172 255) :test #'equal) 
;;#define PURPLE     CLITERAL{ 200, 122, 255, 255 }   // Purple
(define-constant +purple+      '(200 122 255 255) :test #'equal) 
;;#define VIOLET     CLITERAL{ 135, 60, 190, 255 }    // Violet
(define-constant +violet+      '(135 60 190 255) :test #'equal) 
;;#define DARKPURPLE CLITERAL{ 112, 31, 126, 255 }    // Dark Purple
(define-constant +darkpurple+  '(112 31 126 255) :test #'equal) 
;;#define BEIGE      CLITERAL{ 211, 176, 131, 255 }   // Beige
(define-constant +beige+       '(211 176 131 255) :test #'equal) 
;;#define BROWN      CLITERAL{ 127, 106, 79, 255 }    // Brown
(define-constant +brown+       '(127 106 79 255) :test #'equal) 
;;#define DARKBROWN  CLITERAL{ 76, 63, 47, 255 }      // Dark Brown
(define-constant +darkbrown+   '(76 63 47 255) :test #'equal) 
;;
;;#define WHITE      CLITERAL{ 255, 255, 255, 255 }   // White
(define-constant +white+       '(255 255 255 255) :test #'equal) 
;;#define BLACK      CLITERAL{ 0, 0, 0, 255 }         // Black
(define-constant +black+       '(0 0 0 255) :test #'equal) 
;;#define BLANK      CLITERAL{ 0, 0, 0, 0 }           // Blank (Transparent)
(define-constant +blank+       '(0 0 0 0) :test #'equal) 
;;#define MAGENTA    CLITERAL{ 255, 0, 255, 255 }     // Magenta
(define-constant +magenta+     '(255 0 255 255) :test #'equal) 
;;#define RAYWHITE   CLITERAL{ 245, 245, 245, 255 }   // My own White (raylib logo)
(define-constant +raywhite+    '(245 245 245 255) :test #'equal) 
;;// Shader and material limits
;;#define MAX_SHADER_LOCATIONS        32      // Maximum number of predefined locations stored in shader struct
;;#define MAX_MATERIAL_MAPS           12      // Maximum number of texture maps stored in shader struct
;;
;;//----------------------------------------------------------------------------------
;;// Structures Definition
;;//----------------------------------------------------------------------------------
;;#ifndef __cplusplus
;;// Boolean type
;;    #ifndef bool
;;        typedef enum { false, true } bool;
;;    #endif
;;#endif
(defcenum bool
 :false
 :true)

;;
;;// Vector2 type
;;typedef struct Vector2 {
;;    float x;
;;    float y;
;;} Vector2;
(defcstruct (%vector2 :class vector2-type)
 "Vector2 type"
 (x :float)
 (y :float))

(defstruct vector2
 x
 y)

(defmethod translate-into-foreign-memory (object (type vector2-type) pointer)
  (with-foreign-slots ((x y) pointer (:struct %vector2))
                      (setf x (vector2-x object))
                      (setf y (vector2-y object))))

(defmethod translate-from-foreign (pointer (type vector2-type))
  (with-foreign-slots ((x y) pointer (:struct %vector2))
                      (make-vector2 :x x :y y)))

;;// Vector3 type
;;typedef struct Vector3 {
;;    float x;
;;    float y;
;;    float z;
;;} Vector3;
(defcstruct (%vector3 :class vector3-type)
 "Vector3 type"
 (x :float)
 (y :float)
 (z :float))

(defmethod translate-into-foreign-memory (object (type vector3-type) pointer)
  (with-foreign-slots ((x y z) pointer (:struct %vector3))
                      (setf x (nth 0 object))
                      (setf y (nth 1 object))
                      (setf z (nth 2 object))))

(defmethod translate-from-foreign (pointer (type vector3-type))
  (with-foreign-slots ((x y z) pointer (:struct %vector3))
                      (list x y z)))

;;// Vector4 type
;;typedef struct Vector4 {
;;    float x;
;;    float y;
;;    float z;
;;    float w;
;;} Vector4;
(defcstruct (%vector4 :class vector4-type)
 "Vector4 type"
 (x :float)
 (y :float)
 (z :float)
 (w :float))

(defmethod translate-into-foreign-memory (object (type vector4-type) pointer)
  (with-foreign-slots ((x y z w) pointer (:struct %vector4))
                      (setf x (nth 0 object))
                      (setf y (nth 1 object))
                      (setf z (nth 2 object))
		      (setf w (nth 3 object))))

(defmethod translate-from-foreign (pointer (type vector4-type))
  (with-foreign-slots ((x y z w) pointer (:struct %vector4))
                      (list x y z w)))
;;
;;// Quaternion type, same as Vector4
;;typedef Vector4 Quaternion;
;;
;;// Matrix type (OpenGL style 4x4 - right handed, column major)
;;typedef struct Matrix {
;;    float m0, m4, m8, m12;
;;    float m1, m5, m9, m13;
;;    float m2, m6, m10, m14;
;;    float m3, m7, m11, m15;
;;} Matrix;
(defcstruct (%matrix :class matrix-type)
  "Matrix type (OpenGL style 4x4"
  (m0 :float) (m4 :float) (m8 :float) (m12 :float)
  (m1 :float) (m5 :float) (m9 :float) (m13 :float)
  (m2 :float) (m6 :float) (m10 :float) (m14 :float)
  (m3 :float) (m7 :float) (m11 :float) (m15 :float))

(defmethod translate-into-foreign-memory (object (type matrix-type) pointer)
  (with-foreign-slots ((m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15) pointer (:struct %matrix))
                      (setf m0 (nth 0 object))
                      (setf m1 (nth 1 object))
                      (setf m2 (nth 2 object))
                      (setf m3 (nth 3 object))
                      (setf m4 (nth 4 object))
                      (setf m5 (nth 5 object))
                      (setf m6 (nth 6 object))
                      (setf m7 (nth 7 object))
                      (setf m8 (nth 8 object))
                      (setf m9 (nth 9 object))
                      (setf m10 (nth 10 object))
                      (setf m11 (nth 11 object))
                      (setf m12 (nth 12 object))
                      (setf m13 (nth 13 object))
                      (setf m14 (nth 14 object))
                      (setf m15 (nth 15 object))))

(defmethod translate-from-foreign (pointer (type matrix-type))
  (with-foreign-slots ((m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15) pointer (:struct %matrix))
                      (list m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15)))

;;// Color type, RGBA (32bit)
;;typedef struct Color {
;;    unsigned char r;
;;    unsigned char g;
;;    unsigned char b;
;;    unsigned char a;
;;} Color;
(defcstruct (%color :class color-type)
  "Color type, RGBA (32bit)"
  (r :unsigned-char)
  (g :unsigned-char)
  (b :unsigned-char)
  (a :unsigned-char))

(defmethod translate-into-foreign-memory (object (type color-type) pointer)
  (with-foreign-slots ((r g b a) pointer (:struct %color))
                      (setf r (nth 0 object))
                      (setf g (nth 1 object))
                      (setf b (nth 2 object))
                      (setf a (nth 3 object))))

(defmethod translate-from-foreign (pointer (type color-type))
  (with-foreign-slots ((r g b a) pointer (:struct %color))
   (list r g b a)))

;;// Rectangle type
;;typedef struct Rectangle {
;;    float x;
;;    float y;
;;    float width;
;;    float height;
;;} Rectangle;
(defcstruct (%rectangle :class rectangle-type)
  "Rectangle type"
  (x :float)
  (y :float)
  (width :float)
  (height :float))

(defmethod translate-into-foreign-memory (object (type rectangle-type) pointer)
  (with-foreign-slots ((x y width height) pointer (:struct %rectangle))
                      (setf x (nth 0 object))
                      (setf y (nth 1 object))
                      (setf width (nth 2 object))
                      (setf height (nth 3 object))))

(defmethod translate-from-foreign (pointer (type rectangle-type))
  (with-foreign-slots ((x y width height) pointer (:struct %rectangle))
                      (list x y width height)))

;;// Image type, bpp always RGBA (32bit)
;;// NOTE: Data stored in CPU memory (RAM)
;;typedef struct Image {
;;    void *data;             // Image raw data
;;    int width;              // Image base width
;;    int height;             // Image base height
;;    int mipmaps;            // Mipmap levels, 1 by default
;;    int format;             // Data format (PixelFormat type)
;;} Image;
(defcstruct (%image :class image-type)
"Image type, bpp always RGBA (32bit)"
  (data :pointer)
  (width :int)
  (height :int)
  (mipmaps :int)
  (format :int))

(defmethod translate-into-foreign-memory (object (type image-type) pointer)
  (with-foreign-slots ((data width height mipmaps format) pointer (:struct %image))
                      (setf data (nth 0 object))
                      (setf width (nth 1 object))
                      (setf height (nth 2 object))
                      (setf mipmaps (nth 3 object))
                      (setf format (nth 4 object))))

(defmethod translate-from-foreign (pointer (type image-type))
  (with-foreign-slots ((data width height mipmaps format) pointer (:struct %image))
  (list data width height mipmaps format)))

;;// Texture2D type
;;// NOTE: Data stored in GPU memory
;;typedef struct Texture2D {
;;    unsigned int id;        // OpenGL texture id
;;    int width;              // Texture base width
;;    int height;             // Texture base height
;;    int mipmaps;            // Mipmap levels, 1 by default
;;    int format;             // Data format (PixelFormat type)
;;} Texture2D;

;;// Texture type, same as Texture2D
;;typedef Texture2D Texture;
;;
(defcstruct (%texture :class texture-type)
 "Texture type"
 (id :unsigned-int)
 (width :int)
 (height :int)
 (mipmaps :int)
 (format :int))

(defmethod translate-into-foreign-memory (object (type texture-type) pointer)
  (with-foreign-slots ((id width height mipmaps format) pointer (:struct %texture))
                      (setf id (nth 0 object))
                      (setf width (nth 1 object))
                      (setf height (nth 2 object))
                      (setf mipmaps (nth 3 object))
                      (setf format (nth 4 object))))

(defmethod translate-from-foreign (pointer (type texture-type))
  (with-foreign-slots ((id width height mipmaps format) pointer (:struct %texture))
  (list id width height mipmaps format)))

;;// RenderTexture2D type, for texture rendering
;;typedef struct RenderTexture2D {
;;    unsigned int id;        // OpenGL Framebuffer Object (FBO) id
;;    Texture2D texture;      // Color buffer attachment texture
;;    Texture2D depth;        // Depth buffer attachment texture
;;} RenderTexture2D;
;;
;;// RenderTexture type, same as RenderTexture2D
;;typedef RenderTexture2D RenderTexture;
(defcstruct (%render-texture :class render-texture-type)
 "RenderTexture2D type, for texture rendering"
 (id :unsigned-int)
 (texture (:struct %texture))
 (depth (:struct %texture)))

(defmethod translate-into-foreign-memory (object (type render-texture-type) pointer)
  (with-foreign-slots ((id texture depth) pointer (:struct %render-texture))
                      (setf id (nth 0 object))
                      (setf texture (nth 1 object))
                      (setf depth (nth 2 object))))

(defmethod translate-from-foreign (pointer (type render-texture-type))
  (with-foreign-slots ((id texture depth) pointer (:struct %render-texture))
  (list id texture depth)))

;;// Font character info
;;typedef struct CharInfo {
;;    int value;              // Character value (Unicode)
;;    Rectangle rec;          // Character rectangle in sprite font
;;    int offsetX;            // Character offset X when drawing
;;    int offsetY;            // Character offset Y when drawing
;;    int advanceX;           // Character advance position X
;;    unsigned char *data;    // Character pixel data (grayscale)
;;} CharInfo;
(defcstruct (%char-info :class char-info-type)
 "Font character info"
 (value :int)
 (rec (:struct %rectangle))
 (offset-x :int)
 (offset-y :int)
 (advance-x :int)
 (data :pointer))

(defmethod translate-into-foreign-memory (object (type char-info-type) pointer)
  (with-foreign-slots ((value rec offset-x offset-y advance-x data) pointer (:struct %char-info))
                      (setf value (nth 0 object))
                      (setf rec (nth 1 object))
                      (setf offset-x (nth 2 object))
                      (setf offset-y (nth 3 object))
                      (setf advance-x (nth 4 object))
                      (setf data (nth 5 object))))

(defmethod translate-from-foreign (pointer (type char-info-type))
  (with-foreign-slots ((value rec offset-x offset-y advance-x data) pointer (:struct %char-info))
  (list value rec offset-x offset-y advance-x data)))
 
;;
;;// Font type, includes texture and charSet array data
;;typedef struct Font {
;;    Texture2D texture;      // Font texture
;;    int baseSize;           // Base size (default chars height)
;;    int charsCount;         // Number of characters
;;    CharInfo *chars;        // Characters info data
;;} Font;
;;
;;#define SpriteFont Font     // SpriteFont type fallback, defaults to Font
(defcstruct (%font :class font-type)
 "Font type, includes texture and charSet array data"
 (texture (:struct %texture))
 (base-size :int)
 (chars-count :int)
 (chars (:pointer (:struct %char-info))))

(defmethod translate-into-foreign-memory (object (type font-type) pointer)
  (with-foreign-slots ((texture base-size chars-count chars) pointer (:struct %font))
                      (setf texture (nth 0 object))
                      (setf base-size (nth 1 object))
                      (setf chars-count (nth 2 object))
                      (setf chars (nth 3 object))))

(defmethod translate-from-foreign (pointer (type font-type))
  (with-foreign-slots ((texture base-size chars-count chars) pointer (:struct %font))
  (list texture base-size chars-count chars)))

;;// Camera type, defines a camera position/orientation in 3d space
;;typedef struct Camera3D {
;;    Vector3 position;       // Camera position
;;    Vector3 target;         // Camera target it looks-at
;;    Vector3 up;             // Camera up vector (rotation over its axis)
;;    float fovy;             // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
;;    int type;               // Camera type, defines projection type: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
;;} Camera3D;
;;
;;#define Camera Camera3D     // Camera type fallback, defaults to Camera3D
(defcstruct (%camera3d :class camera3d-type)
 "Camera type, defines a camera position/orientation in 3d space"
 (position (:struct %vector3))
 (target (:struct %vector3))
 (up (:struct %vector3))
 (fovy :float)
 (type :int))

(defmethod translate-into-foreign-memory (object (type camera3d-type) pointer)
  (with-foreign-slots ((position target up fovy type) pointer (:struct %camera3d))
                      (setf position (nth 0 object))
                      (setf target (nth 1 object))
                      (setf up (nth 2 object))
                      (setf fovy (nth 3 object))
                      (setf type (nth 4 object))))

(defmethod translate-from-foreign (pointer (type camera3d-type))
  (with-foreign-slots ((position target up fovy type) pointer (:struct %camera3d))
  (list position target up fovy type)))

;;// Camera2D type, defines a 2d camera
;;typedef struct Camera2D {
;;    Vector2 offset;         // Camera offset (displacement from target)
;;    Vector2 target;         // Camera target (rotation and zoom origin)
;;    float rotation;         // Camera rotation in degrees
;;    float zoom;             // Camera zoom (scaling), should be 1.0f by default
;;} Camera2D;
(defcstruct (%camera2d :class camera2d-type)
 "Camera2D type, defines a 2d camera"
 (offset (:struct %vector2))
 (target (:struct %vector2))
 (rotation :float)
 (zoom :float))

(defmethod translate-into-foreign-memory (object (type camera2d-type) pointer)
  (with-foreign-slots ((offset target rotation zoom) pointer (:struct %camera2d))
                      (setf offset (nth 0 object))
                      (setf target (nth 1 object))
                      (setf rotation (nth 2 object))
                      (setf zoom (nth 3 object))))

(defmethod translate-from-foreign (pointer (type camera2d-type))
  (with-foreign-slots ((offset target rotation zoom) pointer (:struct %camera2d))
  (list offset target rotation zoom)))

;;// Bounding box type
;;typedef struct BoundingBox {
;;    Vector3 min;            // Minimum vertex box-corner
;;    Vector3 max;            // Maximum vertex box-corner
;;} BoundingBox;
(defcstruct (%bounding-box :class bounding-box-type)
 "Bounding box type"
 (min (:struct %vector3))
 (max (:struct %vector3)))

(defmethod translate-into-foreign-memory (object (type bounding-box-type) pointer)
 (with-foreign-slots ((min max) pointer (:struct %bounding-box))
                      (setf min (nth 0 object))
                      (setf max (nth 1 object))))

(defmethod translate-from-foreign (pointer (type bounding-box-type))
 (with-foreign-slots ((min max) pointer (:struct %bounding-box))
  (list min max)))

;;// Vertex data definning a mesh
;;// NOTE: Data stored in CPU memory (and GPU)
;;typedef struct Mesh {
;;    int vertexCount;        // Number of vertices stored in arrays
;;    int triangleCount;      // Number of triangles stored (indexed or not)
;;
;;    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
;;    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
;;    float *texcoords2;      // Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
;;    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
;;    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
;;    unsigned char *colors;  // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
;;    unsigned short *indices;// Vertex indices (in case vertex data comes indexed)
;;
;;    unsigned int vaoId;     // OpenGL Vertex Array Object id
;;    unsigned int vboId[7];  // OpenGL Vertex Buffer Objects id (7 types of vertex data)
;;} Mesh;
(defcstruct (%mesh :class mesh-type)
 "Vertex data definning a mesh"
  (vertex-count :int)
  (triangle-count :int)
  (vertices (:pointer :float))
  (texcoords (:pointer :float))
  (texcoords2 (:pointer :float))
  (normals (:pointer :float))
  (tangents (:pointer :float))
  (colors (:pointer :unsigned-char))
  (indices (:pointer :unsigned-short))
  (vao-id :unsigned-int)
  (vbo-id :int :count 7))

(defmethod translate-into-foreign-memory (object (type mesh-type) pointer)
  (with-foreign-slots ((vertex-count triangle-count vertices texcoords texcoords2 normals tangents colors indices vao-id vbo-id) pointer (:struct %mesh))
                      (setf vertex-count (nth 0 object))
                      (setf triangle-count (nth 1 object))
                      (setf vertices (nth 2 object))
                      (setf texcoords (nth 3 object))
                      (setf texcoords2 (nth 4 object))
                      (setf normals (nth 5 object))
                      (setf tangents (nth 6 object))
                      (setf colors (nth 7 object))
                      (setf indices (nth 8 object))
                      (setf vao-id (nth 9 object))
                      (setf vbo-id (nth 10 object))))

(defmethod translate-from-foreign (pointer (type mesh-type))
  (with-foreign-slots ((vertex-count triangle-count vertices texcoords texcoords2 normals tangents colors indices vao-id vbo-id) pointer (:struct %mesh))
                      (list vertex-count triangle-count vertices texcoords texcoords2 normals tangents colors indices vao-id vbo-id)))

;;// Shader type (generic)
;;typedef struct Shader {
;;    unsigned int id;                // Shader program id
;;    int locs[MAX_SHADER_LOCATIONS]; // Shader locations array
;;} Shader;
(defcstruct (%shader :class shader-type)
 "Shader type"
 (id :unsigned-int)
 (locs :int :count 32))
 
 (defmethod translate-into-foreign-memory (object (type shader-type) pointer)
 (with-foreign-slots ((id locs) pointer (:struct %shader))
                      (setf id (nth 0 object))
                      (setf locs (nth 1 object))))

(defmethod translate-from-foreign (pointer (type shader-type))
 (with-foreign-slots ((id locs) pointer (:struct %shader))
 (list id locs)))

;;// Material texture map
;;typedef struct MaterialMap {
;;    Texture2D texture;      // Material map texture
;;    Color color;            // Material map color
;;    float value;            // Material map value
;;} MaterialMap;
(defcstruct (%material-map :class material-map-type)
 "Material texture map"
 (texture (:struct %texture))
 (color (:struct %color))
 (value :float))
 
(defmethod translate-into-foreign-memory (object (type material-map-type) pointer)
 (with-foreign-slots ((texture color value) pointer (:struct %material-map))
                      (setf texture (nth 0 object))
                      (setf color (nth 1 object))
                      (setf value (nth 2 object))))

(defmethod translate-from-foreign (pointer (type material-map-type))
 (with-foreign-slots ((texture color value) pointer (:struct %material-map))
 (list texture color value)))
;;
;;// Material type (generic)
;;typedef struct Material {
;;    Shader shader;          // Material shader
;;    MaterialMap maps[MAX_MATERIAL_MAPS]; // Material maps
;;    float *params;          // Material generic parameters (if required)
;;} Material;

(defcstruct (%material :class material-type)
 "Material type"
 (shader (:struct %shader))
 (maps (:struct %material-map) :count 12)
 (params (:pointer :float)))

(defmethod translate-into-foreign-memory (object (type material-type) pointer)
 (with-foreign-slots ((shader maps params) pointer (:struct %material))
                      (setf shader (nth 0 object))
                      (setf maps (nth 1 object))
                      (setf params (nth 2 object))))

(defmethod translate-from-foreign (pointer (type material-type))
 (with-foreign-slots ((shader maps params) pointer (:struct %material))
 (list shader maps params)))

;;// Model type
;;typedef struct Model {
;;    Mesh mesh;              // Vertex data buffers (RAM and VRAM)
;;    Matrix transform;       // Local transform matrix
;;    Material material;      // Shader and textures data
;;} Model;
(defcstruct (%model :class model-type)
 "Model type"
 (mesh (:struct %mesh))
 (transform (:struct %matrix))
 (material (:struct %material)))

(defmethod translate-into-foreign-memory (object (type model-type) pointer)
 (with-foreign-slots ((mesh transform material) pointer (:struct %model))
                      (setf mesh (nth 0 object))
                      (setf transform (nth 1 object))
                      (setf material (nth 2 object))))

(defmethod translate-from-foreign (pointer (type model-type))
 (with-foreign-slots ((mesh transform material) pointer (:struct %model))
 (list mesh transform material)))

;;// Ray type (useful for raycast)
;;typedef struct Ray {
;;    Vector3 position;       // Ray position (origin)
;;    Vector3 direction;      // Ray direction
;;} Ray;
(defcstruct (%ray :class ray-type)
 "Ray type (useful for raycast)"
 (position (:struct %vector3))
 (direction (:struct %vector3)))

(defmethod translate-into-foreign-memory (object (type ray-type) pointer)
 (with-foreign-slots ((position direction) pointer (:struct %ray))
                      (setf position (nth 0 object))
                      (setf direction (nth 1 object))))

(defmethod translate-from-foreign (pointer (type ray-type))
 (with-foreign-slots ((position direction) pointer (:struct %ray))
 (list position direction)))
;;
;;// Raycast hit information
;;typedef struct RayHitInfo {
;;    bool hit;               // Did the ray hit something?
;;    float distance;         // Distance to nearest hit
;;    Vector3 position;       // Position of nearest hit
;;    Vector3 normal;         // Surface normal of hit
;;} RayHitInfo;
(defcstruct (%ray-hit-info :class ray-hit-info-type)
 "Raycast hit information"
 (hit bool)
 (distance :float)
 (position (:struct %vector3))
 (normal (:struct %vector3)))

(defmethod translate-into-foreign-memory (object (type ray-hit-info-type) pointer)
 (with-foreign-slots ((hit distance position normal) pointer (:struct %ray-hit-info))
                      (setf hit (nth 0 object))
                      (setf distance (nth 1 object))
                      (setf position (nth 2 object))
                      (setf normal (nth 3 object))))

(defmethod translate-from-foreign (pointer (type ray-hit-info-type))
 (with-foreign-slots ((hit distance position normal) pointer (:struct %ray-hit-info))
 (list hit distance position normal)))

;;// Wave type, defines audio wave data
;;typedef struct Wave {
;;    unsigned int sampleCount;   // Number of samples
;;    unsigned int sampleRate;    // Frequency (samples per second)
;;    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
;;    unsigned int channels;      // Number of channels (1-mono, 2-stereo)
;;    void *data;                 // Buffer data pointer
;;} Wave;
(defcstruct (%wave :class wave-type)
 "Wave type, defines audio wave data"
 (sample-count :unsigned-int)
 (sample-rate :unsigned-int)
 (sample-size :unsigned-int)
 (channels :unsigned-int)
 (data :pointer))

(defmethod translate-into-foreign-memory (object (type wave-type) pointer)
 (with-foreign-slots ((sample-count sample-rate sample-size channels data) pointer (:struct %wave))
                      (setf sample-count (nth 0 object))
                      (setf sample-rate (nth 1 object))
                      (setf sample-size (nth 2 object))
                      (setf channels (nth 3 object))
                      (setf data (nth 4 object))))

(defmethod translate-from-foreign (pointer (type wave-type))
 (with-foreign-slots ((sample-count sample-rate sample-size channels data) pointer (:struct %wave))
 (list sample-count sample-rate sample-size channels data)))

;;// Sound source type
;;typedef struct Sound {
;;    void *audioBuffer;      // Pointer to internal data used by the audio system
;;
;;    unsigned int source;    // Audio source id
;;    unsigned int buffer;    // Audio buffer id
;;    int format;             // Audio format specifier
;;} Sound;
(defcstruct (%sound :class sound-type)
 "Sound source type"
 (audio-buffer :pointer)
 (source :unsigned-int)
 (buffer :unsigned-int)
 (format :int))

(defmethod translate-into-foreign-memory (object (type sound-type) pointer)
 (with-foreign-slots ((audio-buffer source buffer format) pointer (:struct %sound))
                      (setf audio-buffer (nth 0 object))
                      (setf source (nth 1 object))
                      (setf buffer (nth 2 object))
                      (setf format (nth 3 object))))

(defmethod translate-from-foreign (pointer (type sound-type))
 (with-foreign-slots ((audio-buffer source buffer format) pointer (:struct %sound))
 (list audio-buffer source buffer format)))

;;// Music type (file streaming from memory)
;;// NOTE: Anything longer than ~10 seconds should be streamed
;;typedef struct MusicData *Music;
(defctype music :pointer)

;;// Audio stream type
;;// NOTE: Useful to create custom audio streams not bound to a specific file
;;typedef struct AudioStream {
;;    unsigned int sampleRate;    // Frequency (samples per second)
;;    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
;;    unsigned int channels;      // Number of channels (1-mono, 2-stereo)
;;
;;    void *audioBuffer;          // Pointer to internal data used by the audio system.
;;
;;    int format;                 // Audio format specifier
;;    unsigned int source;        // Audio source id
;;    unsigned int buffers[2];    // Audio buffers (double buffering)
;;} AudioStream;
(defcstruct (%audio-stream :class audio-stream-type)
 "Audio stream type"
  (sample-rate :unsigned-int)
  (sample-size :unsigned-int)
  (channels :unsigned-int)
  (audio-buffer :pointer)
  (format :int)
  (source :unsigned-int)
  (buffers :unsigned-int :count 2))

(defmethod translate-into-foreign-memory (object (type audio-stream-type) pointer)
 (with-foreign-slots ((sample-rate sample-size channels audio-buffer format source buffers) pointer (:struct %audio-stream))
                      (setf sample-rate (nth 0 object))
                      (setf sample-size (nth 1 object))
                      (setf channels (nth 2 object))
                      (setf audio-buffer (nth 3 object))
                      (setf format (nth 4 object))
                      (setf source (nth 5 object))
                      (setf (mem-aref buffers :unsigned-int 0) (nth 6 object))
                      (setf (mem-aref buffers :unsigned-int 1) (nth 7 object))))

(defmethod translate-from-foreign (pointer (type audio-stream-type))
  (with-foreign-slots ((sample-rate sample-size channels audio-buffer format source buffers) pointer (:struct %audio-stream))
                      (list sample-rate sample-size channels audio-buffer format source (mem-aref buffers :unsigned-int 0) (mem-aref buffers :unsigned-int 1))))


;;
;;// Head-Mounted-Display device parameters
;;typedef struct VrDeviceInfo {
;;    int hResolution;                // HMD horizontal resolution in pixels
;;    int vResolution;                // HMD vertical resolution in pixels
;;    float hScreenSize;              // HMD horizontal size in meters
;;    float vScreenSize;              // HMD vertical size in meters
;;    float vScreenCenter;            // HMD screen center in meters
;;    float eyeToScreenDistance;      // HMD distance between eye and display in meters
;;    float lensSeparationDistance;   // HMD lens separation distance in meters
;;    float interpupillaryDistance;   // HMD IPD (distance between pupils) in meters
;;    float lensDistortionValues[4];  // HMD lens distortion constant parameters
;;    float chromaAbCorrection[4];    // HMD chromatic aberration correction parameters
;;} VrDeviceInfo;
;;
;;//----------------------------------------------------------------------------------
;;// Enumerators Definition
;;//----------------------------------------------------------------------------------
;;// Trace log type
;;typedef enum {
;;    LOG_INFO    = 1,
;;    LOG_WARNING = 2,
;;    LOG_ERROR   = 4,
;;    LOG_DEBUG   = 8,
;;    LOG_OTHER   = 16
;;} LogType;
;;
;;// Shader location point type
;;typedef enum {
;;    LOC_VERTEX_POSITION = 0,
;;    LOC_VERTEX_TEXCOORD01,
;;    LOC_VERTEX_TEXCOORD02,
;;    LOC_VERTEX_NORMAL,
;;    LOC_VERTEX_TANGENT,
;;    LOC_VERTEX_COLOR,
;;    LOC_MATRIX_MVP,
;;    LOC_MATRIX_MODEL,
;;    LOC_MATRIX_VIEW,
;;    LOC_MATRIX_PROJECTION,
;;    LOC_VECTOR_VIEW,
;;    LOC_COLOR_DIFFUSE,
;;    LOC_COLOR_SPECULAR,
;;    LOC_COLOR_AMBIENT,
;;    LOC_MAP_ALBEDO,          // LOC_MAP_DIFFUSE
;;    LOC_MAP_METALNESS,       // LOC_MAP_SPECULAR
;;    LOC_MAP_NORMAL,
;;    LOC_MAP_ROUGHNESS,
;;    LOC_MAP_OCCLUSION,
;;    LOC_MAP_EMISSION,
;;    LOC_MAP_HEIGHT,
;;    LOC_MAP_CUBEMAP,
;;    LOC_MAP_IRRADIANCE,
;;    LOC_MAP_PREFILTER,
;;    LOC_MAP_BRDF
;;} ShaderLocationIndex;
;;
;;#define LOC_MAP_DIFFUSE      LOC_MAP_ALBEDO
;;#define LOC_MAP_SPECULAR     LOC_MAP_METALNESS
;;
;;// Material map type
;;typedef enum {
;;    MAP_ALBEDO    = 0,       // MAP_DIFFUSE
;;    MAP_METALNESS = 1,       // MAP_SPECULAR
;;    MAP_NORMAL    = 2,
;;    MAP_ROUGHNESS = 3,
;;    MAP_OCCLUSION,
;;    MAP_EMISSION,
;;    MAP_HEIGHT,
;;    MAP_CUBEMAP,             // NOTE: Uses GL_TEXTURE_CUBE_MAP
;;    MAP_IRRADIANCE,          // NOTE: Uses GL_TEXTURE_CUBE_MAP
;;    MAP_PREFILTER,           // NOTE: Uses GL_TEXTURE_CUBE_MAP
;;    MAP_BRDF
;;} TexmapIndex;
;;
;;#define MAP_DIFFUSE      MAP_ALBEDO
;;#define MAP_SPECULAR     MAP_METALNESS
;;
;;// Pixel formats
;;// NOTE: Support depends on OpenGL version and platform
;;typedef enum {
;;    UNCOMPRESSED_GRAYSCALE = 1,     // 8 bit per pixel (no alpha)
;;    UNCOMPRESSED_GRAY_ALPHA,        // 8*2 bpp (2 channels)
;;    UNCOMPRESSED_R5G6B5,            // 16 bpp
;;    UNCOMPRESSED_R8G8B8,            // 24 bpp
;;    UNCOMPRESSED_R5G5B5A1,          // 16 bpp (1 bit alpha)
;;    UNCOMPRESSED_R4G4B4A4,          // 16 bpp (4 bit alpha)
;;    UNCOMPRESSED_R8G8B8A8,          // 32 bpp
;;    UNCOMPRESSED_R32,               // 32 bpp (1 channel - float)
;;    UNCOMPRESSED_R32G32B32,         // 32*3 bpp (3 channels - float)
;;    UNCOMPRESSED_R32G32B32A32,      // 32*4 bpp (4 channels - float)
;;    COMPRESSED_DXT1_RGB,            // 4 bpp (no alpha)
;;    COMPRESSED_DXT1_RGBA,           // 4 bpp (1 bit alpha)
;;    COMPRESSED_DXT3_RGBA,           // 8 bpp
;;    COMPRESSED_DXT5_RGBA,           // 8 bpp
;;    COMPRESSED_ETC1_RGB,            // 4 bpp
;;    COMPRESSED_ETC2_RGB,            // 4 bpp
;;    COMPRESSED_ETC2_EAC_RGBA,       // 8 bpp
;;    COMPRESSED_PVRT_RGB,            // 4 bpp
;;    COMPRESSED_PVRT_RGBA,           // 4 bpp
;;    COMPRESSED_ASTC_4x4_RGBA,       // 8 bpp
;;    COMPRESSED_ASTC_8x8_RGBA        // 2 bpp
;;} PixelFormat;
;;
;;// Texture parameters: filter mode
;;// NOTE 1: Filtering considers mipmaps if available in the texture
;;// NOTE 2: Filter is accordingly set for minification and magnification
;;typedef enum {
;;    FILTER_POINT = 0,               // No filter, just pixel aproximation
;;    FILTER_BILINEAR,                // Linear filtering
;;    FILTER_TRILINEAR,               // Trilinear filtering (linear with mipmaps)
;;    FILTER_ANISOTROPIC_4X,          // Anisotropic filtering 4x
;;    FILTER_ANISOTROPIC_8X,          // Anisotropic filtering 8x
;;    FILTER_ANISOTROPIC_16X,         // Anisotropic filtering 16x
;;} TextureFilterMode;
;;
;;// Texture parameters: wrap mode
;;typedef enum {
;;    WRAP_REPEAT = 0,
;;    WRAP_CLAMP,
;;    WRAP_MIRROR
;;} TextureWrapMode;
;;
;;// Color blending modes (pre-defined)
;;typedef enum {
;;    BLEND_ALPHA = 0,
;;    BLEND_ADDITIVE,
;;    BLEND_MULTIPLIED
;;} BlendMode;
;;
;;// Gestures type
;;// NOTE: It could be used as flags to enable only some gestures
;;typedef enum {
;;    GESTURE_NONE        = 0,
;;    GESTURE_TAP         = 1,
;;    GESTURE_DOUBLETAP   = 2,
;;    GESTURE_HOLD        = 4,
;;    GESTURE_DRAG        = 8,
;;    GESTURE_SWIPE_RIGHT = 16,
;;    GESTURE_SWIPE_LEFT  = 32,
;;    GESTURE_SWIPE_UP    = 64,
;;    GESTURE_SWIPE_DOWN  = 128,
;;    GESTURE_PINCH_IN    = 256,
;;    GESTURE_PINCH_OUT   = 512
;;} Gestures;
;;
;;// Camera system modes
;;typedef enum {
;;    CAMERA_CUSTOM = 0,
;;    CAMERA_FREE,
;;    CAMERA_ORBITAL,
;;    CAMERA_FIRST_PERSON,
;;    CAMERA_THIRD_PERSON
;;} CameraMode;
;;
;;// Camera projection modes
;;typedef enum {
;;    CAMERA_PERSPECTIVE = 0,
;;    CAMERA_ORTHOGRAPHIC
;;} CameraType;
;;
;;// Head Mounted Display devices
;;typedef enum {
;;    HMD_DEFAULT_DEVICE = 0,
;;    HMD_OCULUS_RIFT_DK2,
;;    HMD_OCULUS_RIFT_CV1,
;;    HMD_OCULUS_GO,
;;    HMD_VALVE_HTC_VIVE,
;;    HMD_SONY_PSVR
;;} VrDeviceType;
;;
;;#ifdef __cplusplus
;;extern "C" {            // Prevents name mangling of functions
;;#endif
;;
;;//------------------------------------------------------------------------------------
;;// Global Variables Definition
;;//------------------------------------------------------------------------------------
;;// It's lonely here...
;;
;;//------------------------------------------------------------------------------------
;;// Window and Graphics Device Functions (Module: core)
;;//------------------------------------------------------------------------------------
;;
;;// Window-related functions
;;RLAPI void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context
(defcfun "InitWindow" :void
 "Initialize window and OpenGL context"
         (width :int)
         (height :int)
         (title :string))
		 
;;RLAPI void CloseWindow(void);                                     // Close window and unload OpenGL context
(defcfun "CloseWindow" :void
 "Close window and unload OpenGL context")

;;RLAPI bool IsWindowReady(void);                                   // Check if window has been initialized successfully
(defcfun "IsWindowReady" bool
 "Check if window has been initialized successfully")

;;RLAPI bool WindowShouldClose(void);                               // Check if KEY_ESCAPE pressed or Close icon pressed
(defcfun "WindowShouldClose" bool
 "Check if KEY_ESCAPE pressed or Close icon pressed")

;;RLAPI bool IsWindowMinimized(void);                               // Check if window has been minimized (or lost focus)
(defcfun "IsWindowMinimized" bool
 "Check if window has been minimized (or lost focus)")

;;RLAPI void ToggleFullscreen(void);                                // Toggle fullscreen mode (only PLATFORM_DESKTOP)
(defcfun "ToggleFullscreen" :void
 "Toggle fullscreen mode (only PLATFORM_DESKTOP)")

;;RLAPI void SetWindowIcon(Image image);                            // Set icon for window (only PLATFORM_DESKTOP)
(defcfun "SetWindowIcon" :void
 "Set icon for window (only PLATFORM_DESKTOP)"
 (image (:struct %image)))

;;RLAPI void SetWindowTitle(const char *title);                     // Set title for window (only PLATFORM_DESKTOP)
(defcfun "SetWindowTitle" :void
 "Set title for window (only PLATFORM_DESKTOP)"
 (title :string))

;;RLAPI void SetWindowPosition(int x, int y);                       // Set window position on screen (only PLATFORM_DESKTOP)
(defcfun "SetWindowPosition" :void
 "Set window position on screen (only PLATFORM_DESKTOP)"
 (x :int)
 (y :int))

;;RLAPI void SetWindowMonitor(int monitor);                         // Set monitor for the current window (fullscreen mode)
(defcfun "SetWindowMonitor" :void
 "Set monitor for the current window (fullscreen mode)"
 (monitor :int))

;;RLAPI void SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
(defcfun "SetWindowMinSize" :void
 "Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)"
 (width :int)
 (height :int))

;;RLAPI void SetWindowSize(int width, int height);                  // Set window dimensions
(defcfun "SetWindowSize" :void
 "Set window dimensions"
 (width :int)
 (height :int))

;;RLAPI int GetScreenWidth(void);                                   // Get current screen width
(defcfun "GetScreenWidth" :int
 "Get current screen width")

;;RLAPI int GetScreenHeight(void);                                  // Get current screen height
(defcfun "GetScreenHeight" :int
 "Get current screen height")

;;// Cursor-related functions
;;RLAPI void ShowCursor(void);                                      // Shows cursor
(defcfun "ShowCursor" :void
 "Shows cursor")

;;RLAPI void HideCursor(void);                                      // Hides cursor
(defcfun "HideCursor" :void
 "Hides cursor")

;;RLAPI bool IsCursorHidden(void);                                  // Check if cursor is not visible
(defcfun "IsCursorHidden" bool
 "Check if cursor is not visible")

;;RLAPI void EnableCursor(void);                                    // Enables cursor (unlock cursor)
(defcfun "EnableCursor" :void
 "Enables cursor (unlock cursor)")

;;RLAPI void DisableCursor(void);                                   // Disables cursor (lock cursor)
(defcfun "DisableCursor" :void
 "Disables cursor (lock cursor)")

;;// Drawing-related functions
;;RLAPI void ClearBackground(Color color);                          // Set background color (framebuffer clear color)
(defcfun "ClearBackground" :void
 "Set background color (framebuffer clear color)"
 (color (:struct %color)))

;;RLAPI void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing
(defcfun "BeginDrawing" :void
 "Setup canvas (framebuffer) to start drawing")

;;RLAPI void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)
(defcfun "EndDrawing" :void
 "End canvas drawing and swap buffers (double buffering)")

;;RLAPI void BeginMode2D(Camera2D camera);                          // Initialize 2D mode with custom camera (2D)
(defcfun "BeginMode2D" :void
 "Initialize 2D mode with custom camera (2D)"
 (camera (:struct %camera2d)))

;;RLAPI void EndMode2D(void);                                       // Ends 2D mode with custom camera
(defcfun "EndMode2D" :void
 "Ends 2D mode with custom camera")

;;RLAPI void BeginMode3D(Camera3D camera);                          // Initializes 3D mode with custom camera (3D)
(defcfun "BeginMode3D" :void
 "Initializes 3D mode with custom camera (3D)"
 (camera (:struct %camera3d)))

;;RLAPI void EndMode3D(void);                                       // Ends 3D mode and returns to default 2D orthographic mode
(defcfun "EndMode3D" :void
 "Ends 3D mode and returns to default 2D orthographic mode")

;;RLAPI void BeginTextureMode(RenderTexture2D target);              // Initializes render texture for drawing
(defcfun "BeginTextureMode" :void
 "Initializes render texture for drawing"
 (target (:struct %render-texture)))

;;RLAPI void EndTextureMode(void);                                  // Ends drawing to render texture
(defcfun "EndTextureMode" :void
 "Ends drawing to render texture")

;;// Screen-space-related functions
;;RLAPI Ray GetMouseRay(Vector2 mousePosition, Camera camera);      // Returns a ray trace from mouse position
(defcfun "GetMouseRay" (:struct %ray)
 "Returns a ray trace from mouse position"
 (mouse-position (:struct %vector2))
 (camera (:struct %camera3d)))

;;RLAPI Vector2 GetWorldToScreen(Vector3 position, Camera camera);  // Returns the screen space position for a 3d world space position
(defcfun "GetWorldToScreen" (:struct %vector2)
 "Returns the screen space position for a 3d world space position"
 (position (:struct %vector3))
 (camera (:struct %camera3d)))

;;RLAPI Matrix GetCameraMatrix(Camera camera);                      // Returns camera transform matrix (view matrix)
(defcfun "GetCameraMatrix" (:struct %matrix)
 "Returns camera transform matrix (view matrix)"
 (camera (:struct %camera3d)))

;;// Timming-related functions
;;RLAPI void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
(defcfun "SetTargetFPS" :void
 "Set target FPS (maximum)"
 (fps :int))

;;RLAPI int GetFPS(void);                                           // Returns current FPS
(defcfun "GetFPS" :int
 "Returns current FPS")

;;RLAPI float GetFrameTime(void);                                   // Returns time in seconds for last frame drawn
(defcfun "GetFrameTime" :float
 "Returns time in seconds for last frame drawn")

;;RLAPI double GetTime(void);                                       // Returns elapsed time in seconds since InitWindow()
(defcfun "GetTime" :double
 "Returns elapsed time in seconds since InitWindow()")

;;
;;// Color-related functions
;;RLAPI int ColorToInt(Color color);                                // Returns hexadecimal value for a Color
(defcfun "ColorToInt" :int
 "Returns hexadecimal value for a Color"
 (color (:struct %color)))

;;RLAPI Vector4 ColorNormalize(Color color);                        // Returns color normalized as float [0..1]
(defcfun "ColorNormalize" (:struct %vector4)
 "Returns color normalized as float [0..1]"
 (color (:struct %color)))

;;RLAPI Vector3 ColorToHSV(Color color);                            // Returns HSV values for a Color
(defcfun "ColorToHSV" (:struct %vector3)
 "Returns HSV values for a Color"
 (color (:struct %color)))

;;RLAPI Color GetColor(int hexValue);                               // Returns a Color struct from hexadecimal value
(defcfun "GetColor" (:struct %color)
 "Returns a Color struct from hexadecimal value"
 (hex-value :int))

;;RLAPI Color Fade(Color color, float alpha);                       // Color fade-in or fade-out, alpha goes from 0.0f to 1.0f
(defcfun "Fade" (:struct %color)
 "Color fade-in or fade-out, alpha goes from 0.0f to 1.0f"
 (color (:struct %color))
 (alpha :float))

;;// Misc. functions
;;RLAPI void ShowLogo(void);                                        // Activate raylib logo at startup (can be done with flags)
(defcfun "ShowLogo" :void
 "Activate raylib logo at startup (can be done with flags)")

;;RLAPI void SetConfigFlags(unsigned char flags);                   // Setup window configuration flags (view FLAGS)
(defcfun "SetConfigFlags" :void
 "Setup window configuration flags (view FLAGS)"
 (flags :unsigned-char))

;;RLAPI void SetTraceLog(unsigned char types);                      // Enable trace log message types (bit flags based)
(defcfun "SetTraceLog" :void
 "Enable trace log message types (bit flags based)"
 (types :unsigned-char))

;;RLAPI void TraceLog(int logType, const char *text, ...);          // Show trace log messages (LOG_INFO, LOG_WARNING, LOG_ERROR, LOG_DEBUG)
(defcfun "TraceLog" :void
 "Show trace log messages (LOG_INFO, LOG_WARNING, LOG_ERROR, LOG_DEBUG)"
 (log-type :int)
 (text :string)
 &rest)

;;RLAPI void TakeScreenshot(const char *fileName);                  // Takes a screenshot of current screen (saved a .png)
(defcfun "TakeScreenshot" :void
 "Takes a screenshot of current screen (saved a .png)"
 (file-name :string))

;;RLAPI int GetRandomValue(int min, int max);                       // Returns a random value between min and max (both included)
(defcfun "GetRandomValue" :int
 "Returns a random value between min and max (both included)"
 (min :int)
 (max :int))

;;// Files management functions
;;RLAPI bool IsFileExtension(const char *fileName, const char *ext);// Check file extension
(defcfun "IsFileExtension" bool
 "Check file extension"
 (file-name :string)
 (ext :string))

;;RLAPI const char *GetExtension(const char *fileName);             // Get pointer to extension for a filename string
(defcfun "GetExtension" :string
 "Get pointer to extension for a filename string"
 (file-name :string))

;;RLAPI const char *GetFileName(const char *filePath);              // Get pointer to filename for a path string
(defcfun "GetFileName" :string
 "Get pointer to filename for a path string"
 (file-path :string))

;;RLAPI const char *GetDirectoryPath(const char *fileName);         // Get full path for a given fileName (uses static string)
(defcfun "GetDirectoryPath" :string
 "Get full path for a given fileName (uses static string)"
 (file-name :string))

;;RLAPI const char *GetWorkingDirectory(void);                      // Get current working directory (uses static string)
(defcfun "GetWorkingDirectory" :string
 "Get current working directory (uses static string)")

;;RLAPI bool ChangeDirectory(const char *dir);                      // Change working directory, returns true if success
(defcfun "ChangeDirectory" bool
 "Change working directory, returns true if success"
 (dir :string))

;;RLAPI bool IsFileDropped(void);                                   // Check if a file has been dropped into window
(defcfun "IsFileDropped" bool
 "Check if a file has been dropped into window")

;;RLAPI char **GetDroppedFiles(int *count);                         // Get dropped files names
(defcfun "GetDroppedFiles" :pointer
 "Get dropped files names"
 (count :pointer))

;;RLAPI void ClearDroppedFiles(void);                               // Clear dropped files paths buffer
(defcfun "ClearDroppedFiles" :void
 "Clear dropped files paths buffer")

;;// Persistent storage management
;;RLAPI void StorageSaveValue(int position, int value);             // Save integer value to storage file (to defined position)
(defcfun "StorageSaveValue" :void
 "Save integer value to storage file (to defined position)"
 (position :int)
 (value :int))

;;RLAPI int StorageLoadValue(int position);                         // Load integer value from storage file (from defined position)
(defcfun "StorageLoadValue" :int
 "Load integer value from storage file (from defined position)"
 (position :int))

;;//------------------------------------------------------------------------------------
;;// Input Handling Functions (Module: core)
;;//------------------------------------------------------------------------------------
;;
;;// Input-related functions: keyboard
;;RLAPI bool IsKeyPressed(int key);                             // Detect if a key has been pressed once
(defcfun "IsKeyPressed" bool
 "Detect if a key has been pressed once"
 (key :int))

;;RLAPI bool IsKeyDown(int key);                                // Detect if a key is being pressed
(defcfun "IsKeyDown" bool
 "Detect if a key is being pressed"
 (key :int))

;;RLAPI bool IsKeyReleased(int key);                            // Detect if a key has been released once
(defcfun "IsKeyReleased" bool
 "Detect if a key has been released once"
 (key :int))

;;RLAPI bool IsKeyUp(int key);                                  // Detect if a key is NOT being pressed
(defcfun "IsKeyUp" bool
 "Detect if a key is NOT being pressed"
 (key :int))

;;RLAPI int GetKeyPressed(void);                                // Get latest key pressed
(defcfun "GetKeyPressed" :int
 "Get latest key pressed")

;;RLAPI void SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)
(defcfun "SetExitKey" :void
 "Set a custom key to exit program (default is ESC)"
 (key :int))

;;
;;// Input-related functions: gamepads
;;RLAPI bool IsGamepadAvailable(int gamepad);                   // Detect if a gamepad is available
(defcfun "IsGamepadAvailable" bool
 "Detect if a gamepad is available"
 (gamepad :int))

;;RLAPI bool IsGamepadName(int gamepad, const char *name);      // Check gamepad name (if available)
(defcfun "IsGamepadName" bool
 "Check gamepad name (if available)"
 (gamepad :int)
 (name :string))

;;RLAPI const char *GetGamepadName(int gamepad);                // Return gamepad internal name id
(defcfun "GetGamepadName" :string
 "Return gamepad internal name id"
 (gamepad :int))

;;RLAPI bool IsGamepadButtonPressed(int gamepad, int button);   // Detect if a gamepad button has been pressed once
(defcfun "IsGamepadButtonPressed" bool
 "Detect if a gamepad button has been pressed once"
 (gamepad :int)
 (button :int))

;;RLAPI bool IsGamepadButtonDown(int gamepad, int button);      // Detect if a gamepad button is being pressed
(defcfun "IsGamepadButtonDown" bool
 "Detect if a gamepad button is being pressed"
 (gamepad :int)
 (button :int))

;;RLAPI bool IsGamepadButtonReleased(int gamepad, int button);  // Detect if a gamepad button has been released once
(defcfun "IsGamepadButtonReleased" bool
 "Detect if a gamepad button has been released once"
 (gamepad :int)
 (button :int))

;;RLAPI bool IsGamepadButtonUp(int gamepad, int button);        // Detect if a gamepad button is NOT being pressed
(defcfun "IsGamepadButtonUp" bool
 "Detect if a gamepad button is NOT being pressed"
 (gamepad :int)
 (button :int))

;;RLAPI int GetGamepadButtonPressed(void);                      // Get the last gamepad button pressed
(defcfun "GetGamepadButtonPressed" :int
 "Get the last gamepad button pressed")

;;RLAPI int GetGamepadAxisCount(int gamepad);                   // Return gamepad axis count for a gamepad
(defcfun "GetGamepadAxisCount" :int
 "Return gamepad axis count for a gamepad"
 (gamepad :int))

;;RLAPI float GetGamepadAxisMovement(int gamepad, int axis);    // Return axis movement value for a gamepad axis
(defcfun "GetGamepadAxisMovement" :float
 "Return axis movement value for a gamepad axis"
 (gamepad :int)
 (axis :int))

;;
;;// Input-related functions: mouse
;;RLAPI bool IsMouseButtonPressed(int button);                  // Detect if a mouse button has been pressed once
(defcfun "IsMouseButtonPressed" bool
 "Detect if a mouse button has been pressed once"
 (button :int))

;;RLAPI bool IsMouseButtonDown(int button);                     // Detect if a mouse button is being pressed
(defcfun "IsMouseButtonDown" bool
 "Detect if a mouse button is being pressed"
 (button :int))

;;RLAPI bool IsMouseButtonReleased(int button);                 // Detect if a mouse button has been released once
(defcfun "IsMouseButtonReleased" bool
 "Detect if a mouse button has been released once"
 (button :int))

;;RLAPI bool IsMouseButtonUp(int button);                       // Detect if a mouse button is NOT being pressed
(defcfun "IsMouseButtonUp" bool
 "Detect if a mouse button is NOT being pressed"
 (button :int))

;;RLAPI int GetMouseX(void);                                    // Returns mouse position X
(defcfun "GetMouseX" :int
 "Returns mouse position X")

;;RLAPI int GetMouseY(void);                                    // Returns mouse position Y
(defcfun "GetMouseY" :int
 "Returns mouse position Y")

;;RLAPI Vector2 GetMousePosition(void);                         // Returns mouse position XY
(defcfun "GetMousePosition" (:struct %vector2)
 "Returns mouse position XY")

;;RLAPI void SetMousePosition(Vector2 position);                // Set mouse position XY
(defcfun "SetMousePosition" :void
 "Set mouse position XY"
 (position (:struct %vector2)))

;;RLAPI void SetMouseScale(float scale);                        // Set mouse scaling
(defcfun "SetMouseScale" :void
 "Set mouse scaling"
 (scale :float))

;;RLAPI int GetMouseWheelMove(void);                            // Returns mouse wheel movement Y
(defcfun "GetMouseWheelMove" :int
 "Returns mouse wheel movement Y")

;;
;;// Input-related functions: touch
;;RLAPI int GetTouchX(void);                                    // Returns touch position X for touch point 0 (relative to screen size)
(defcfun "GetTouchX" :int
 "Returns touch position X for touch point 0 (relative to screen size)")

;;RLAPI int GetTouchY(void);                                    // Returns touch position Y for touch point 0 (relative to screen size)
(defcfun "GetTouchY" :int
 "Returns touch position Y for touch point 0 (relative to screen size)")

;;RLAPI Vector2 GetTouchPosition(int index);                    // Returns touch position XY for a touch point index (relative to screen size)
(defcfun "GetTouchPosition" (:struct %vector2)
 "Returns touch position XY for a touch point index (relative to screen size)"
 (index :int))

;;//------------------------------------------------------------------------------------
;;// Gestures and Touch Handling Functions (Module: gestures)
;;//------------------------------------------------------------------------------------
;;RLAPI void SetGesturesEnabled(unsigned int gestureFlags);     // Enable a set of gestures using flags
(defcfun "SetGesturesEnabled" :void
 "Enable a set of gestures using flags"
 (gesture-flags :unsigned-int))

;;RLAPI bool IsGestureDetected(int gesture);                    // Check if a gesture have been detected
(defcfun "IsGestureDetected" bool
 "Check if a gesture have been detected"
 (gesture :int))

;;RLAPI int GetGestureDetected(void);                           // Get latest detected gesture
(defcfun "GetGestureDetected" :int
 "Get latest detected gesture")

;;RLAPI int GetTouchPointsCount(void);                          // Get touch points count
(defcfun "GetTouchPointsCount" :int
 "Get touch points count")

;;RLAPI float GetGestureHoldDuration(void);                     // Get gesture hold time in milliseconds
(defcfun "GetGestureHoldDuration" :float
 "Get gesture hold time in milliseconds")

;;RLAPI Vector2 GetGestureDragVector(void);                     // Get gesture drag vector
(defcfun "GetGestureDragVector" (:struct %vector2)
 "Get gesture drag vector")

;;RLAPI float GetGestureDragAngle(void);                        // Get gesture drag angle
(defcfun "GetGestureDragAngle" :float
 "Get gesture drag angle")

;;RLAPI Vector2 GetGesturePinchVector(void);                    // Get gesture pinch delta
(defcfun "GetGesturePinchVector" (:struct %vector2)
 "Get gesture pinch delta")

;;RLAPI float GetGesturePinchAngle(void);                       // Get gesture pinch angle
(defcfun "GetGesturePinchAngle" :float
 "Get gesture pinch angle")

;;//------------------------------------------------------------------------------------
;;// Camera System Functions (Module: camera)
;;//------------------------------------------------------------------------------------
;;RLAPI void SetCameraMode(Camera camera, int mode);                // Set camera mode (multiple camera modes available)
(defcfun "SetCameraMode" :void
 "Set camera mode (multiple camera modes available)"
 (camera (:struct %camera3d))
 (mode :int))

;;RLAPI void UpdateCamera(Camera *camera);                          // Update camera position for selected mode
(defcfun "UpdateCamera" :void
 (camera (:pointer (:struct %camera3d))))

;;RLAPI void SetCameraPanControl(int panKey);                       // Set camera pan key to combine with mouse movement (free camera)
(defcfun "SetCameraPanControl" :void
 (pan-key :int))

;;RLAPI void SetCameraAltControl(int altKey);                       // Set camera alt key to combine with mouse movement (free camera)
(defcfun "SetCameraAltControl" :void
 (alt-key :int))

;;RLAPI void SetCameraSmoothZoomControl(int szKey);                 // Set camera smooth zoom key to combine with mouse (free camera)
(defcfun "SetCameraSmoothZoomControl" :void
 "Set camera smooth zoom key to combine with mouse (free camera)"
 (sz-key :int))

;;RLAPI void SetCameraMoveControls(int frontKey, int backKey, int rightKey, int leftKey, int upKey, int downKey); // Set camera move controls (1st person and 3rd person cameras)
(defcfun "SetCameraMoveControls" :void
 "Set camera move controls (1st person and 3rd person cameras)"
 (front-key :int)
 (back-key :int)
 (right-key :int)
 (left-key :int)
 (up-key :int)
 (down-key :int))

;;//------------------------------------------------------------------------------------
;;// Basic Shapes Drawing Functions (Module: shapes)
;;//------------------------------------------------------------------------------------
;;
;;// Basic shapes drawing functions
;;RLAPI void DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel
(defcfun "DrawPixel" :void
 "Draw a pixel"
 (pos-x :int)
 (pos-y :int)
 (color (:struct %color)))

;;RLAPI void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel (Vector version)
(defcfun "DrawPixelV" :void
 "Draw a pixel (Vector version)"
 (position (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line
(defcfun "DrawLine" :void
 "Draw a line"
 (start-pos-x :int)
 (start-pos-y :int)
 (end-pos-x :int)
 (end-pos-y :int))

;;RLAPI void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (Vector version)
(defcfun "DrawLineV" :void
 "Draw a line (Vector version)"
 (start-pos (:struct %vector2))
 (end-pos (:struct %vector2))
 (color (:struct %color)))
 
;;RLAPI void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line defining thickness
(defcfun "DrawLineEx" :void
 "Draw a line defining thickness"
 (start-pos (:struct %vector2))
 (end-pos (:struct %vector2))
 (thick :float)
 (color (:struct %color)))

;;RLAPI void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw a line using cubic-bezier curves in-out
(defcfun "DrawLineBezier" :void
 "Draw a line using cubic-bezier curves in-out"
 (start-pos (:struct %vector2))
 (end-pos (:struct %vector2))
 (thick :float)
 (color (:struct %color)))

;;RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle
(defcfun "DrawCircle" :void
 "Draw a color-filled circle"
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);       // Draw a gradient-filled circle
(defcfun "DrawCircleGradient" :void
 "Draw a gradient-filled circle"
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color1 (:struct %color))
 (color2 (:struct %color)))

;;RLAPI void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)
(defcfun "DrawCircleV" :void
 "Draw a color-filled circle (Vector version)"
 (center (:struct %vector2))
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline
(defcfun "DrawCircleLines" :void
 "Draw circle outline"
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle
(defcfun "DrawRectangle" :void
 "Draw a color-filled rectangle"
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color (:struct %color)))

;;RLAPI void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)
(defcfun "DrawRectangleV" :void
 "Draw a color-filled rectangle (Vector version)"
 (position (:struct %vector2))
 (size (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
(defcfun "DrawRectangleRec" :void
 "Draw a color-filled rectangle"
 (rec (:struct %rectangle))
 (color (:struct %color)))

;;RLAPI void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters
(defcfun "DrawRectanglePro" :void
 "Draw a color-filled rectangle with pro parameters"
 (rec (:struct %rectangle))
 (origin (:struct %vector2))
 (rotation :float)
 (color (:struct %color)))

;;RLAPI void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a vertical-gradient-filled rectangle
(defcfun "DrawRectangleGradientV" :void
 "Draw a vertical-gradient-filled rectangle"
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color1 (:struct %color))
 (color2 (:struct %color)))

;;RLAPI void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a horizontal-gradient-filled rectangle
(defcfun "DrawRectangleGradientH" :void
 "Draw a horizontal-gradient-filled rectangle"
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color1 (:struct %color))
 (color2 (:struct %color)))

;;RLAPI void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       // Draw a gradient-filled rectangle with custom vertex colors
(defcfun "DrawRectangleGradientEx" :void
 "Draw a gradient-filled rectangle with custom vertex colors"
 (rec (:struct %rectangle))
 (col1 (:struct %color))
 (col2 (:struct %color))
 (col3 (:struct %color))
 (col4 (:struct %color)))

;;RLAPI void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline
(defcfun "DrawRectangleLines" :void
 "Draw rectangle outline"
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color (:struct %color)))
 
;;RLAPI void DrawRectangleLinesEx(Rectangle rec, int lineThick, Color color);                              // Draw rectangle outline with extended parameters
(defcfun "DrawRectangleLinesEx" :void
 "Draw rectangle outline with extended parameters"
 (rec (:struct %rectangle))
 (line-thick :int)
 (color (:struct %color)))

;;RLAPI void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle
(defcfun "DrawTriangle" :void
 "Draw a color-filled triangle"
 (v1 (:struct %vector2))
 (v2 (:struct %vector2))
 (v3 (:struct %vector2))
 (color (:struct %color)))
 
;;RLAPI void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline
(defcfun "DrawTriangleLines" :void
 (v1 (:struct %vector2))
 (v2 (:struct %vector2))
 (v3 (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)
(defcfun "DrawPoly" :void
 (center (:struct %vector2))
 (sides :int)
 (radius :float)
 (rotation :float)
 (color (:struct %color)))

;;RLAPI void DrawPolyEx(Vector2 *points, int numPoints, Color color);                                      // Draw a closed polygon defined by points
(defcfun "DrawPolyEx" :void
 (points (:pointer (:struct %vector2)))
 (num-points :int)
 (color (:struct %color)))

;;RLAPI void DrawPolyExLines(Vector2 *points, int numPoints, Color color);                                 // Draw polygon lines
(defcfun "DrawPolyExLines" :void
 (points (:pointer (:struct %vector2)))
 (num-points :int)
 (color (:struct %color)))

;;// Basic shapes collision detection functions
;;RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles
(defcfun "CheckCollisionRecs" bool
 (rec1 (:struct %rectangle))
 (rec2 (:struct %rectangle)))

;;RLAPI bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles
(defcfun "CheckCollisionCircles" bool
 (center1 (:struct %vector2))
 (radius1 :float)
 (center2 (:struct %vector2))
 (radius2 :float))

;;RLAPI bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle
(defcfun "CheckCollisionCircleRec" bool
 (center (:struct %vector2))
 (radius :float)
 (rec (:struct %rectangle)))

;;RLAPI Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision
(defcfun "GetCollisionRec" (:struct %rectangle)
 (rec1 (:struct %rectangle))
 (rec2 (:struct %rectangle)))

;;RLAPI bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle
(defcfun "CheckCollisionPointRec" bool
 (point (:struct %vector2))
 (rec (:struct %rectangle)))

;;RLAPI bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle
(defcfun "CheckCollisionPointCircle" bool
 (point (:struct %vector2))
 (center (:struct %vector2))
 (radius :float))

;;RLAPI bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle
(defcfun "CheckCollisionPointTriangle" bool
 (point (:struct %vector2))
 (p1 (:struct %vector2))
 (p2 (:struct %vector2))
 (p3 (:struct %vector2)))

;;//------------------------------------------------------------------------------------
;;// Texture Loading and Drawing Functions (Module: textures)
;;//------------------------------------------------------------------------------------
;;
;;// Image/Texture2D data loading/unloading/saving functions
;;RLAPI Image LoadImage(const char *fileName);                                                             // Load image from file into CPU memory (RAM)
(defcfun "LoadImage" (:struct %image)
 (file-name :string))

;;RLAPI Image LoadImageEx(Color *pixels, int width, int height);                                           // Load image from Color array data (RGBA - 32bit)
(defcfun "LoadImageEx" (:struct %image)
 (pixels (:pointer (:struct %color)))
 (width :int)
 (height :int))
 
;;RLAPI Image LoadImagePro(void *data, int width, int height, int format);                                 // Load image from raw data with parameters
(defcfun "LoadImagePro" (:struct %image)
 "Load image from raw data with parameters"
 (data :pointer)
 (width :int)
 (height :int)
 (format :int))

;;RLAPI Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       // Load image from RAW file data
(defcfun "LoadImageRaw" (:struct %image)
 (file-name :string)
 (width :int)
 (height :int)
 (format :int)
 (header-size :int))

;;RLAPI void ExportImage(const char *fileName, Image image);                                               // Export image as a PNG file
(defcfun "ExportImage" :void
 "Export image as a PNG file"
 (file-name :string)
 (image (:struct %image)))

;;RLAPI Texture2D LoadTexture(const char *fileName);                                                       // Load texture from file into GPU memory (VRAM)
(defcfun "LoadTexture" (:struct %texture)
 (file-name :string))

;;RLAPI Texture2D LoadTextureFromImage(Image image);                                                       // Load texture from image data
(defcfun "LoadTextureFromImage" (:struct %texture)
 (image (:struct %image)))

;;RLAPI RenderTexture2D LoadRenderTexture(int width, int height);                                          // Load texture for rendering (framebuffer)
(defcfun "LoadRenderTexture" (:struct %render-texture)
 (width :int)
 (height :int))

;;RLAPI void UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)
(defcfun "UnloadImage" :void
 (image (:struct %image)))

;;RLAPI void UnloadTexture(Texture2D texture);                                                             // Unload texture from GPU memory (VRAM)
(defcfun "UnloadTexture" :void
 (texture (:struct %texture)))

;;RLAPI void UnloadRenderTexture(RenderTexture2D target);                                                  // Unload render texture from GPU memory (VRAM)
(defcfun "UnloadRenderTexture" :void
 (target (:struct %render-texture)))

;;RLAPI Color *GetImageData(Image image);                                                                  // Get pixel data from image as a Color struct array
(defcfun "GetImageData" (:pointer (:struct %color))
 (image (:struct %image)))

;;RLAPI int GetPixelDataSize(int width, int height, int format);                                           // Get pixel data size in bytes (image or texture)
(defcfun "GetPixelDataSize" :int
 "Get pixel data size in bytes (image or texture)"
 (width :int)
 (height :int)
 (format :int))

;;RLAPI Image GetTextureData(Texture2D texture);                                                           // Get pixel data from GPU texture and return an Image
(defcfun "GetTextureData" (:struct %image)
 (texture (:struct %texture)))

;;RLAPI void UpdateTexture(Texture2D texture, const void *pixels);                                         // Update GPU texture with new data
(defcfun "UpdateTexture" :void
 (texture (:struct %texture))
 (pixels :pointer))

;;// Image manipulation functions
;;RLAPI Image ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)
(defcfun "ImageCopy" (:struct %image)
 "Create an image duplicate (useful for transformations)"
 (image (:struct %image)))

;;RLAPI void ImageToPOT(Image *image, Color fillColor);                                                    // Convert image to POT (power-of-two)
(defcfun "ImageToPOT" :void
 (image (:pointer (:struct %image)))
 (fill-color (:struct %color)))

;;RLAPI void ImageFormat(Image *image, int newFormat);                                                     // Convert image data to desired format
(defcfun "ImageFormat" :void
 (image (:pointer (:struct %image)))
 (new-format :int))

;;RLAPI void ImageAlphaMask(Image *image, Image alphaMask);                                                // Apply alpha mask to image
(defcfun "ImageAlphaMask" :void
 (image (:pointer (:struct %image)))
 (alpha-mask (:struct %image)))

;;RLAPI void ImageAlphaClear(Image *image, Color color, float threshold);                                  // Clear alpha channel to desired color
;;RLAPI void ImageAlphaCrop(Image *image, float threshold);                                                // Crop image depending on alpha value
;;RLAPI void ImageAlphaPremultiply(Image *image);                                                          // Premultiply alpha channel
;;RLAPI void ImageCrop(Image *image, Rectangle crop);                                                      // Crop an image to a defined rectangle
(defcfun "ImageCrop" :void
 (image (:pointer (:struct %image)))
 (crop (:struct %rectangle)))

;;RLAPI void ImageResize(Image *image, int newWidth, int newHeight);                                       // Resize image (bilinear filtering)
(defcfun "ImageResize" :void
 (image (:pointer (:struct %image)))
 (new-width :int)
 (new-height :int))
 
;;RLAPI void ImageResizeNN(Image *image, int newWidth,int newHeight);                                      // Resize image (Nearest-Neighbor scaling algorithm)
;;RLAPI void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color color);  // Resize canvas and fill with color
;;RLAPI void ImageMipmaps(Image *image);                                                                   // Generate all mipmap levels for a provided image
;;RLAPI void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
;;RLAPI Image ImageText(const char *text, int fontSize, Color color);                                      // Create an image from text (default font)
(defcfun "ImageText" (:struct %image)
 (text :string)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         // Create an image from text (custom sprite font)
(defcfun "ImageTextEx" (:struct %image)
 (font (:struct %font))
 (text :string)
 (font-size :float)
 (spacing :float)
 (tint (:struct %color)))
 
;;RLAPI void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec);                         // Draw a source image within a destination image
(defcfun "ImageDraw" :void
 (dst (:pointer (:struct %image)))
 (src (:struct %image))
 (src-rec (:struct %rectangle))
 (dst-rec (:struct %rectangle)))

;;RLAPI void ImageDrawRectangle(Image *dst, Vector2 position, Rectangle rec, Color color);                 // Draw rectangle within an image
;;RLAPI void ImageDrawText(Image *dst, Vector2 position, const char *text, int fontSize, Color color);     // Draw text (default font) within an image (destination)
(defcfun "ImageDrawText" :void
 (dst (:pointer (:struct %image)))
 (position (:struct %vector2))
 (text :string)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI void ImageDrawTextEx(Image *dst, Vector2 position, Font font, const char *text, float fontSize, float spacing, Color color); // Draw text (custom sprite font) within an image (destination)
;;RLAPI void ImageFlipVertical(Image *image);                                                              // Flip image vertically
(defcfun "ImageFlipVertical" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageFlipHorizontal(Image *image);                                                            // Flip image horizontally
(defcfun "ImageFlipHorizontal" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageRotateCW(Image *image);                                                                  // Rotate image clockwise 90deg
;;RLAPI void ImageRotateCCW(Image *image);                                                                 // Rotate image counter-clockwise 90deg
;;RLAPI void ImageColorTint(Image *image, Color color);                                                    // Modify image color: tint
(defcfun "ImageColorTint" :void
 (image (:pointer (:struct %image)))
 (color (:struct %color)))

;;RLAPI void ImageColorInvert(Image *image);                                                               // Modify image color: invert
(defcfun "ImageColorInvert" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageColorGrayscale(Image *image);                                                            // Modify image color: grayscale
(defcfun "ImageColorGrayscale" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageColorContrast(Image *image, float contrast);                                             // Modify image color: contrast (-100 to 100)
(defcfun "ImageColorContrast" :void
 (image (:pointer (:struct %image)))
 (contrast :float))

;;RLAPI void ImageColorBrightness(Image *image, int brightness);                                           // Modify image color: brightness (-255 to 255)
(defcfun "ImageColorBrightness" :void
 (image (:pointer (:struct %image)))
 (brightness :int))


;;RLAPI void ImageColorReplace(Image *image, Color color, Color replace);                                  // Modify image color: replace color
;;
;;// Image generation functions
;;RLAPI Image GenImageColor(int width, int height, Color color);                                           // Generate image: plain color
;;RLAPI Image GenImageGradientV(int width, int height, Color top, Color bottom);                           // Generate image: vertical gradient
;;RLAPI Image GenImageGradientH(int width, int height, Color left, Color right);                           // Generate image: horizontal gradient
;;RLAPI Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      // Generate image: radial gradient
;;RLAPI Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    // Generate image: checked
;;RLAPI Image GenImageWhiteNoise(int width, int height, float factor);                                     // Generate image: white noise
;;RLAPI Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);           // Generate image: perlin noise
;;RLAPI Image GenImageCellular(int width, int height, int tileSize);                                       // Generate image: cellular algorithm. Bigger tileSize means bigger cells
;;
;;// Texture2D configuration functions
;;RLAPI void GenTextureMipmaps(Texture2D *texture);                                                        // Generate GPU mipmaps for a texture
(defcfun "GenTextureMipmaps" :void
 (texture (:pointer (:struct %texture))))

;;RLAPI void SetTextureFilter(Texture2D texture, int filterMode);                                          // Set texture scaling filter mode
(defcfun "SetTextureFilter" :void
 (texture (:struct %texture))
 (filter-mode :int))

;;RLAPI void SetTextureWrap(Texture2D texture, int wrapMode);                                              // Set texture wrapping mode
(defcfun "SetTextureWrap" :void
 (texture (:struct %texture))
 (wrap-mode :int))

;;// Texture2D drawing functions
;;RLAPI void DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               // Draw a Texture2D
(defcfun "DrawTexture" :void
 (texture (:struct %texture))
 (pos-x :int)
 (pos-y :int)
 (tint (:struct %color)))

;;RLAPI void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                // Draw a Texture2D with position defined as Vector2
(defcfun "DrawTextureV" :void
 (texture (:struct %texture))
 (position (:struct %vector2))
 (tint (:struct %color)))

;;RLAPI void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  // Draw a Texture2D with extended parameters
(defcfun "DrawTextureEx" :void
 (texture (:struct %texture))
 (position (:struct %vector2))
 (rotation :float)
 (scale :float)
 (tint (:struct %color)))

;;RLAPI void DrawTextureRec(Texture2D texture, Rectangle sourceRec, Vector2 position, Color tint);         // Draw a part of a texture defined by a rectangle
(defcfun "DrawTextureRec" :void
 (texture (:struct %texture))
 (source-rec (:struct %rectangle))
 (position (:struct %vector2))
 (tint (:struct %color)))

;;RLAPI void DrawTexturePro(Texture2D texture, Rectangle sourceRec, Rectangle destRec, Vector2 origin, float rotation, Color tint); // Draw a part of a texture defined by a rectangle with 'pro' parameters
;;
;;//------------------------------------------------------------------------------------
;;// Font Loading and Text Drawing Functions (Module: text)
;;//------------------------------------------------------------------------------------
;;
;;// Font loading/unloading functions
;;RLAPI Font GetFontDefault(void);                                                            // Get the default Font
(defcfun "GetFontDefault" (:struct %font))

;;RLAPI Font LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)
(defcfun "LoadFont" (:struct %font)
 (file-name :string))

;;RLAPI Font LoadFontEx(const char *fileName, int fontSize, int charsCount, int *fontChars);  // Load font from file with extended parameters
;;RLAPI CharInfo *LoadFontData(const char *fileName, int fontSize, int *fontChars, int charsCount, bool sdf); // Load font data for further use
;;RLAPI Image GenImageFontAtlas(CharInfo *chars, int fontSize, int charsCount, int padding, int packMethod);  // Generate image font atlas using chars info
;;RLAPI void UnloadFont(Font font);                                                           // Unload Font from GPU memory (VRAM)
;;
;;// Text drawing functions
;;RLAPI void DrawFPS(int posX, int posY);                                                     // Shows current FPS
(defcfun "DrawFPS" :void
 (pos-x :int)
 (pos-y :int))

;;RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)
(defcfun "DrawText" :void
 "Draw text (using default font)"
 (text :string)
 (pos-x :int)
 (pos-y :int)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI void DrawTextEx(Font font, const char* text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters
;;
;;// Text misc. functions
;;RLAPI int MeasureText(const char *text, int fontSize);                                      // Measure string width for default font
;;RLAPI Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font
;;RLAPI const char *FormatText(const char *text, ...);                                        // Formatting of text with variables to 'embed'
(defcfun "FormatText" :string
 (text :string)
 &rest)

;;RLAPI const char *SubText(const char *text, int position, int length);                      // Get a piece of a text string
(defcfun "SubText" :string
 (text :string)
 (position :int)
 (length :int))

;;RLAPI int GetGlyphIndex(Font font, int character);                                          // Get index position for a unicode character on font
;;
;;//------------------------------------------------------------------------------------
;;// Basic 3d Shapes Drawing Functions (Module: models)
;;//------------------------------------------------------------------------------------
;;
;;// Basic geometric 3D shapes drawing functions
;;RLAPI void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space
(defcfun "DrawLine3D" :void
 (start-pos (:struct %vector3))
 (end-pos (:struct %vector3))
 (color (:struct %color)))

;;RLAPI void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space
(defcfun "DrawCircle3D" :void
 (position (:struct %vector3))
 (radius :float)
 (rotation-axis (:struct %vector3))
 (rotation-angle :float)
 (color (:struct %color)))

;;RLAPI void DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube
(defcfun "DrawCube" :void
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)
(defcfun "DrawCubeV" :void
 (position (:struct %vector3))
 (size (:struct %vector3))
 (color (:struct %color)))

;;RLAPI void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires
(defcfun "DrawCubeWires" :void
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color); // Draw cube textured
(defcfun "DrawCubeTexture" :void
 (texture (:struct %texture))
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere
(defcfun "DrawSphere" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            // Draw sphere with extended parameters
(defcfun "DrawSphereEx" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (rings :int)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         // Draw sphere wires
(defcfun "DrawSphereWires" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (rings :int)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone
(defcfun "DrawCylinder" :void
 (position (:struct %vector3))
 (radius-top :float)
 (radius-bottom :float)
 (height :float)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires
(defcfun "DrawCylinderWires" :void
 (position (:struct %vector3))
 (radius-top :float)
 (radius-bottom :float)
 (height :float)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ
(defcfun "DrawPlance" :void
 (current-pos (:struct %vector3))
 (size  (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawRay(Ray ray, Color color);                                                                // Draw a ray line
(defcfun "DrawRay" :void
 (ray (:struct %ray))
 (color (:struct %color)))

;;RLAPI void DrawGrid(int slices, float spacing);                                                          // Draw a grid (centered at (0, 0, 0))
(defcfun "DrawGrid" :void
 (slices :int)
 (spacing :float))

;;RLAPI void DrawGizmo(Vector3 position);                                                                  // Draw simple gizmo
(defcfun "DrawGizmo" :void
 (position (:struct %vector3)))

;;//DrawTorus(), DrawTeapot() could be useful?
;;
;;//------------------------------------------------------------------------------------
;;// Model 3d Loading and Drawing Functions (Module: models)
;;//------------------------------------------------------------------------------------
;;
;;// Model loading/unloading functions
;;RLAPI Model LoadModel(const char *fileName);                                                            // Load model from files (mesh and material)
(defcfun "LoadModel" (:struct %model)
 (file-name :string))

;;RLAPI Model LoadModelFromMesh(Mesh mesh);                                                               // Load model from generated mesh
;;RLAPI void UnloadModel(Model model);                                                                    // Unload model from memory (RAM and/or VRAM)
(defcfun "UnloadModel" :void
 (model (:struct %model)))

;;// Mesh loading/unloading functions
;;RLAPI Mesh LoadMesh(const char *fileName);                                                              // Load mesh from file
;;RLAPI void UnloadMesh(Mesh *mesh);                                                                      // Unload mesh from memory (RAM and/or VRAM)
;;RLAPI void ExportMesh(const char *fileName, Mesh mesh);                                                 // Export mesh as an OBJ file
;;
;;// Mesh manipulation functions
;;RLAPI BoundingBox MeshBoundingBox(Mesh mesh);                                                           // Compute mesh bounding box limits
;;RLAPI void MeshTangents(Mesh *mesh);                                                                    // Compute mesh tangents
;;RLAPI void MeshBinormals(Mesh *mesh);                                                                   // Compute mesh binormals
;;
;;// Mesh generation functions
;;RLAPI Mesh GenMeshPlane(float width, float length, int resX, int resZ);                                 // Generate plane mesh (with subdivisions)
;;RLAPI Mesh GenMeshCube(float width, float height, float length);                                        // Generate cuboid mesh
;;RLAPI Mesh GenMeshSphere(float radius, int rings, int slices);                                          // Generate sphere mesh (standard sphere)
;;RLAPI Mesh GenMeshHemiSphere(float radius, int rings, int slices);                                      // Generate half-sphere mesh (no bottom cap)
;;RLAPI Mesh GenMeshCylinder(float radius, float height, int slices);                                     // Generate cylinder mesh
;;RLAPI Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);                               // Generate torus mesh
;;RLAPI Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);                                // Generate trefoil knot mesh
;;RLAPI Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                             // Generate heightmap mesh from image data
;;RLAPI Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                                           // Generate cubes-based map mesh from image data
;;
;;// Material loading/unloading functions
;;RLAPI Material LoadMaterial(const char *fileName);                                                      // Load material from file
(defcfun "LoadMaterial" (:struct %material)
 (file-name :string))

;;RLAPI Material LoadMaterialDefault(void);                                                               // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
(defcfun "LoadMaterialDefault" (:struct %material))

;;RLAPI void UnloadMaterial(Material material);                                                           // Unload material from GPU memory (VRAM)
(defcfun "UnloadMaterial" :void
  (material (:struct %material)))

;;// Model drawing functions
;;RLAPI void DrawModel(Model model, Vector3 position, float scale, Color tint);                           // Draw a model (with texture if set)
(defcfun "DrawModel" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters
(defcfun "DrawModelEx" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (rotation-axis (:struct %vector3))
  (rotation-angle :float)
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelWires(Model model, Vector3 position, float scale, Color tint);                      // Draw a model wires (with texture if set)
(defcfun "DrawModelWires" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters
(defcfun "DrawModelWiresEx" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (rotation-axis (:struct %vector3))
  (rotation-angle :float)
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawBoundingBox(BoundingBox box, Color color);                                               // Draw bounding box (wires)
(defcfun "DrawBoundingBox" :void
  (box (:struct %bounding-box))
  (color (:struct %color)))

;;RLAPI void DrawBillboard(Camera camera, Texture2D texture, Vector3 center, float size, Color tint);     // Draw a billboard texture
(defcfun "DrawBillboard" :void
  (camera (:struct %camera3d))
  (texture (:struct %texture))
  (center (:struct %vector3))
  (size :float)
  (tint (:struct %color)))

;;RLAPI void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle sourceRec, Vector3 center, float size, Color tint); // Draw a billboard texture defined by sourceRec
(defcfun "DrawBillboardRec" :void
  (camera (:struct %camera3d))
  (texture (:struct %texture))
  (source-rec (:struct %rectangle))
  (center (:struct %vector3))
  (size :float)
  (tint (:struct %color)))

;;// Collision detection functions
;;RLAPI bool CheckCollisionSpheres(Vector3 centerA, float radiusA, Vector3 centerB, float radiusB);       // Detect collision between two spheres
(defcfun "CheckCollisionSpheres" bool
  (center-a (:struct %vector3))
  (radius-a :float)
  (center-b (:struct %vector3))
  (radius-b :float))

;;RLAPI bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                     // Detect collision between two bounding boxes
(defcfun "CheckCollisionBoxes" bool
  (box1 (:struct %bounding-box))
  (box2 (:struct %bounding-box)))

;;RLAPI bool CheckCollisionBoxSphere(BoundingBox box, Vector3 centerSphere, float radiusSphere);          // Detect collision between box and sphere
(defcfun "CheckCollisionBoxSphere" bool
  (box (:struct %bounding-box))
  (center-sphere (:struct %vector3))
  (sphere-radius :float))

;;RLAPI bool CheckCollisionRaySphere(Ray ray, Vector3 spherePosition, float sphereRadius);                // Detect collision between ray and sphere
(defcfun "CheckCollisionRaySphere" bool
  (ray (:struct %ray))
  (sphere-position (:struct %vector3))
  (sphere-radius :float))

;;RLAPI bool CheckCollisionRaySphereEx(Ray ray, Vector3 spherePosition, float sphereRadius, Vector3 *collisionPoint); // Detect collision between ray and sphere, returns collision point
(defcfun "CheckCollisionRaySphereEx" bool
  (ray (:struct %ray))
  (sphere-position (:struct %vector3))
  (sphere-radius :float)
  (collision-point (:pointer (:struct %vector3))))

;;RLAPI bool CheckCollisionRayBox(Ray ray, BoundingBox box);                                              // Detect collision between ray and box
(defcfun "CheckCollisionRayBox" bool
  (ray (:struct %ray))
  (box (:struct %bounding-box)))

;;RLAPI RayHitInfo GetCollisionRayModel(Ray ray, Model *model);                                           // Get collision info between ray and model
;;RLAPI RayHitInfo GetCollisionRayTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);                  // Get collision info between ray and triangle
;;RLAPI RayHitInfo GetCollisionRayGround(Ray ray, float groundHeight);                                    // Get collision info between ray and ground plane (Y-normal plane)
;;
;;//------------------------------------------------------------------------------------
;;// Shaders System Functions (Module: rlgl)
;;// NOTE: This functions are useless when using OpenGL 1.1
;;//------------------------------------------------------------------------------------
;;
;;// Shader loading/unloading functions
;;RLAPI char *LoadText(const char *fileName);                               // Load chars array from text file
;;RLAPI Shader LoadShader(const char *vsFileName, const char *fsFileName);  // Load shader from files and bind default locations
(defcfun "LoadShader" (:struct %shader)
  (vs-file-name :string)
  (fs-file-name :string))

;;RLAPI Shader LoadShaderCode(char *vsCode, char *fsCode);                  // Load shader from code strings and bind default locations
;;RLAPI void UnloadShader(Shader shader);                                   // Unload shader from GPU memory (VRAM)
(defcfun "UnloadShader" :void
  (shader (:struct %shader)))

;;RLAPI Shader GetShaderDefault(void);                                      // Get default shader
(defcfun "GetShaderDefault" (:struct %shader))

;;RLAPI Texture2D GetTextureDefault(void);                                  // Get default texture
(defcfun "GetTextureDefault" (:struct %texture))

;;// Shader configuration functions
;;RLAPI int GetShaderLocation(Shader shader, const char *uniformName);              // Get shader uniform location
;;RLAPI void SetShaderValue(Shader shader, int uniformLoc, const float *value, int size); // Set shader uniform value (float)
(defcfun "SetShaderValue" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (value (:pointer :float))
  (size :int))
;;RLAPI void SetShaderValuei(Shader shader, int uniformLoc, const int *value, int size);  // Set shader uniform value (int)
(defcfun "SetShaderValuei" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (value (:pointer :int))
  (size :int))
;;RLAPI void SetShaderValueMatrix(Shader shader, int uniformLoc, Matrix mat);       // Set shader uniform value (matrix 4x4)
(defcfun "SetShaderValueMatrix" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (mat (:struct %matrix)))
;;RLAPI void SetMatrixProjection(Matrix proj);                              // Set a custom projection matrix (replaces internal projection matrix)
(defcfun "SetMatrixProjection" :void
  (proj (:struct %matrix)))
;;RLAPI void SetMatrixModelview(Matrix view);                               // Set a custom modelview matrix (replaces internal modelview matrix)
(defcfun "SetMatrixModelview" :void
  (view (:struct %matrix)))
;;RLAPI Matrix GetMatrixModelview();                                        // Get internal modelview matrix
;;
;;// Texture maps generation (PBR)
;;// NOTE: Required shaders should be provided
;;RLAPI Texture2D GenTextureCubemap(Shader shader, Texture2D skyHDR, int size);       // Generate cubemap texture from HDR texture
;;RLAPI Texture2D GenTextureIrradiance(Shader shader, Texture2D cubemap, int size);   // Generate irradiance texture using cubemap data
;;RLAPI Texture2D GenTexturePrefilter(Shader shader, Texture2D cubemap, int size);    // Generate prefilter texture using cubemap data
;;RLAPI Texture2D GenTextureBRDF(Shader shader, Texture2D cubemap, int size);         // Generate BRDF texture using cubemap data
;;
;;// Shading begin/end functions
;;RLAPI void BeginShaderMode(Shader shader);                                // Begin custom shader drawing
(defcfun "BeginShaderMode" :void
  (shader (:struct %shader)))
;;RLAPI void EndShaderMode(void);                                           // End custom shader drawing (use default shader)
(defcfun "EndShaderMode" :void)

;;RLAPI void BeginBlendMode(int mode);                                      // Begin blending mode (alpha, additive, multiplied)
(defcfun "BeginBlendMode" :void
  (mode :int))
;;RLAPI void EndBlendMode(void);                                            // End blending mode (reset to default: alpha blending)
(defcfun "EndBlendMode" :void)
;;
;;// VR control functions
;;RLAPI VrDeviceInfo GetVrDeviceInfo(int vrDeviceType);   // Get VR device information for some standard devices
;;RLAPI void InitVrSimulator(VrDeviceInfo info);          // Init VR simulator for selected device parameters
;;RLAPI void CloseVrSimulator(void);                      // Close VR simulator for current device
;;RLAPI bool IsVrSimulatorReady(void);                    // Detect if VR simulator is ready
;;RLAPI void SetVrDistortionShader(Shader shader);        // Set VR distortion shader for stereoscopic rendering
;;RLAPI void UpdateVrTracking(Camera *camera);            // Update VR tracking (position and orientation) and camera
(defcfun "UpdateVrTracking" :void
  (camera (:pointer (:struct %camera3d))))
  
;;RLAPI void ToggleVrMode(void);                          // Enable/Disable VR experience
(defcfun "ToggleVrMode" :void
 "Enable/Disable VR experience")

;;RLAPI void BeginVrDrawing(void);                        // Begin VR simulator stereo rendering
(defcfun "BeginVrDrawing" :void
 "Begin VR simulator stereo rendering")

;;RLAPI void EndVrDrawing(void);                          // End VR simulator stereo rendering
(defcfun "EndVrDrawing" :void
 "End VR simulator stereo rendering")

;;//------------------------------------------------------------------------------------
;;// Audio Loading and Playing Functions (Module: audio)
;;//------------------------------------------------------------------------------------
;;
;;// Audio device management functions
;;RLAPI void InitAudioDevice(void);                                     // Initialize audio device and context
(defcfun "InitAudioDevice" :void
 "Initialize audio device and context")

;;RLAPI void CloseAudioDevice(void);                                    // Close the audio device and context
(defcfun "CloseAudioDevice" :void
 "Close the audio device and context")

;;RLAPI bool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully
(defcfun "IsAudioDeviceReady" bool
 "Check if audio device has been initialized successfully")

;;RLAPI void SetMasterVolume(float volume);                             // Set master volume (listener)
(defcfun "SetMasterVolume" :void
 "Set master volume (listener)"
 (volume :float))

;;// Wave/Sound loading/unloading functions
;;RLAPI Wave LoadWave(const char *fileName);                            // Load wave data from file
(defcfun "LoadWave" (:struct %wave)
 "Load wave data from file"
  (file-name :string))

;;RLAPI Wave LoadWaveEx(void *data, int sampleCount, int sampleRate, int sampleSize, int channels); // Load wave data from raw array data
(defcfun "LoadWaveEx" (:struct %wave)
 "Load wave data from raw array data"
  (data :pointer)
  (sample-count :int)
  (sample-rate :int)
  (sample-size :int)
  (channels :int))

;;RLAPI Sound LoadSound(const char *fileName);                          // Load sound from file
(defcfun "LoadSound" (:struct %sound)
 "Load sound from file"
  (file-name :string))

;;RLAPI Sound LoadSoundFromWave(Wave wave);                             // Load sound from wave data
(defcfun "LoadSoundFromWave" (:struct %sound)
 "Load sound from wave data"
  (wave (:struct %wave)))

;;RLAPI void UpdateSound(Sound sound, const void *data, int samplesCount);// Update sound buffer with new data
(defcfun "UpdateSound" :void
 "Update sound buffer with new data"
  (sound (:struct %sound))
  (data :pointer)
  (samples-count :int))

;;RLAPI void UnloadWave(Wave wave);                                     // Unload wave data
(defcfun "UnloadWave" :void
 "Unload wave data"
  (wave (:struct %wave)))

;;RLAPI void UnloadSound(Sound sound);                                  // Unload sound
(defcfun "UnloadSound" :void
 "Unload sound"
  (sound (:struct %sound)))

;;// Wave/Sound management functions
;;RLAPI void PlaySound(Sound sound);                                    // Play a sound
(defcfun "PlaySound" :void
 "Play a sound"
  (sound (:struct %sound)))

;;RLAPI void PauseSound(Sound sound);                                   // Pause a sound
(defcfun "PauseSound" :void
 "Pause a sound"
  (sound (:struct %sound)))

;;RLAPI void ResumeSound(Sound sound);                                  // Resume a paused sound
(defcfun "ResumeSound" :void
 "Resume a paused sound"
  (sound (:struct %sound)))

;;RLAPI void StopSound(Sound sound);                                    // Stop playing a sound
(defcfun "StopSound" :void
 "Stop playing a sound"
  (sound (:struct %sound)))

;;RLAPI bool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing
(defcfun "IsSoundPlaying" bool
 "Check if a sound is currently playing"
  (sound (:struct %sound)))

;;RLAPI void SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)
(defcfun "SetSoundVolume" :void
 "Set volume for a sound (1.0 is max level)"
 (sound (:struct %sound))
 (volume :float))

;;RLAPI void SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)
(defcfun "SetSoundPitch" :void
 "Set pitch for a sound (1.0 is base level)"
 (sound (:struct %sound))
 (pitch :float))

;;RLAPI void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);  // Convert wave data to desired format
(defcfun "WaveFormat" :void
 "Convert wave data to desired format"
 (wave (:pointer (:struct %wave)))
 (sample-rate :int)
 (sample-size :int)
 (channels :int))

;;RLAPI Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave
(defcfun "WaveCopy" (:struct %wave)
 "Copy a wave to a new wave"
 (wave (:struct %wave)))

;;RLAPI void WaveCrop(Wave *wave, int initSample, int finalSample);     // Crop a wave to defined samples range
(defcfun "WaveCrop" :void
 "Crop a wave to defined samples range"
 (wave (:pointer (:struct %wave)))
 (init-sample :int)
 (final-sample :int))

;;RLAPI float *GetWaveData(Wave wave);                                  // Get samples data from wave as a floats array
(defcfun "GetWaveData" (:pointer :float)
 "Get samples data from wave as a floats array"
 (wave (:struct %wave)))

;;// Music management functions
;;RLAPI Music LoadMusicStream(const char *fileName);                    // Load music stream from file
(defcfun "LoadMusicStream" music
 "Load music stream from file"
 (file-name :string))

;;RLAPI void UnloadMusicStream(Music music);                            // Unload music stream
(defcfun "UnloadMusicStream" :void
 "Unload music stream"
 (music music))

;;RLAPI void PlayMusicStream(Music music);                              // Start music playing
(defcfun "PlayMusicStream" :void
 "Start music playing"
 (music music))

;;RLAPI void UpdateMusicStream(Music music);                            // Updates buffers for music streaming
(defcfun "UpdateMusicStream" :void
 "Updates buffers for music streaming"
 (music music))

;;RLAPI void StopMusicStream(Music music);                              // Stop music playing
(defcfun "StopMusicStream" :void
 "Stop music playing"
 (music music))

;;RLAPI void PauseMusicStream(Music music);                             // Pause music playing
(defcfun "PauseMusicStream" :void
 "Pause music playing"
 (music music))

;;RLAPI void ResumeMusicStream(Music music);                            // Resume playing paused music
(defcfun "ResumeMusicStream" :void
 "Resume playing paused music"
 (music music))

;;RLAPI bool IsMusicPlaying(Music music);                               // Check if music is playing
(defcfun "IsMusicPlaying" bool
 "Check if music is playing"
 (music music))

;;RLAPI void SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)
(defcfun "SetMusicVolume" :void
 "Set volume for music (1.0 is max level)"
 (music music)
 (volume :float))

;;RLAPI void SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)
(defcfun "SetMusicPitch" :void
 "Set pitch for a music (1.0 is base level)"
 (music music)
 (pitch :float))

;;RLAPI void SetMusicLoopCount(Music music, int count);                 // Set music loop count (loop repeats)
(defcfun "SetMusicLoopCount" :void
 "Set music loop count (loop repeats)"
 (music music)
 (count :int))

;;RLAPI float GetMusicTimeLength(Music music);                          // Get music time length (in seconds)
(defcfun "GetMusicTimeLength" :float
 "Get music time length (in seconds)"
 (music music))

;;RLAPI float GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)
(defcfun "GetMusicTimePlayed" :float
 "Get current music time played (in seconds)"
 (music music))


;;// AudioStream management functions
;;RLAPI AudioStream InitAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Init audio stream (to stream raw audio pcm data)
(defcfun "InitAudioStream" (:struct %audio-stream)
 "Init audio stream (to stream raw audio pcm data)"
 (sample-rate :unsigned-int)
 (sample-size :unsigned-int)
 (channels :unsigned-int))

;;RLAPI void UpdateAudioStream(AudioStream stream, const void *data, int samplesCount); // Update audio stream buffers with data
(defcfun "UpdateAudioStream" :void
 "Update audio stream buffers with data"
 (stream (:struct %audio-stream))
 (data :pointer)
 (samples-count :int))

;;RLAPI void CloseAudioStream(AudioStream stream);                      // Close audio stream and free memory
(defcfun "CloseAudioStream" :void
 "Close audio stream and free memory"
 (stream (:struct %audio-stream)))

;;RLAPI bool IsAudioBufferProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill
(defcfun "IsAudioBufferProcessed" bool
 "Check if any audio stream buffers requires refill"
 (stream (:struct %audio-stream)))

;;RLAPI void PlayAudioStream(AudioStream stream);                       // Play audio stream
(defcfun "PlayAudioStream" :void
 "Play audio stream"
 (stream (:struct %audio-stream)))

;;RLAPI void PauseAudioStream(AudioStream stream);                      // Pause audio stream
(defcfun "PauseAudioStream" :void
 "Pause audio stream"
 (stream (:struct %audio-stream)))

;;RLAPI void ResumeAudioStream(AudioStream stream);                     // Resume audio stream
(defcfun "ResumeAudioStream" :void
 "Resume audio stream"
 (stream (:struct %audio-stream)))

;;RLAPI bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing
(defcfun "IsAudioStreamPlaying" bool
 "Check if audio stream is playing"
 (stream (:struct %audio-stream)))

;;RLAPI void StopAudioStream(AudioStream stream);                       // Stop audio stream
(defcfun "StopAudioStream" :void
 "Stop audio stream"
 (stream (:struct %audio-stream)))

;;RLAPI void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)
(defcfun "SetAudioStreamVolume" :void
 "Set volume for audio stream (1.0 is max level)"
 (stream (:struct %audio-stream))
 (volume :float))

;;RLAPI void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)
(defcfun "SetAudioStreamPitch" :void
 "Set pitch for audio stream (1.0 is base level)"
 (stream (:struct %audio-stream))
 (pitch :float))

;;#ifdef __cplusplus
;;}
;;#endif

;;#endif // RAYLIB_H
