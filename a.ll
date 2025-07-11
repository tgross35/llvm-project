; define void @store_32(i32 %a, ptr %p) nounwind {
; entry:
;   store i32 %a, ptr %p
;   ret void
; }

; define i32 @load_32(ptr %p) nounwind {
; entry:
;   %0 = load i32, ptr %p, align 16
;   ret i32 %0
; }

; define void @store_64(i64 %a, ptr %p) nounwind {
; entry:
;   store i64 %a, ptr %p
;   ret void
; }

; define i64 @load_64(ptr %p) nounwind {
; entry:
;   %0 = load i64, ptr %p, align 16
;   ret i64 %0
; }

define void @store_128(i128 %a, ptr %p) nounwind {
entry:
  store i128 %a, ptr %p, align 16
  ret void
}

define void @store_1282(i8 %_, i128 %a, ptr %p) nounwind {
entry:
  store i128 %a, ptr %p, align 16
  ret void
}

define i128 @load_128(ptr %p) nounwind {
entry:
  %0 = load i128, ptr %p, align 16
  ret i128 %0
}
