@.str = private unnamed_addr constant [18 x i8] c"Sent from LLVM IR\00"
declare i32 @puts(i8* nocapture) nounwind
define void @llvm_ir() {
    %cast210 = getelementptr [18 x i8],[18 x i8]* @.str, i64 0, i64 0

    call i32 @puts(i8* %cast210)
    ret void
}