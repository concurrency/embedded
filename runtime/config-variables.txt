#ifndef RUNTIME_TVM_CONFIG_H_SEEN
#define RUNTIME_TVM_CONFIG_H_SEEN

/* set to the wordlength of the target */
#define TVM_WORD_LENGTH 4
/* define to emulate a T8 processor */
#define TVM_EMULATE_T8 1
/* define for Darwin TVM */
#define TVM_OS_DARWIN 1
/* define to enable occam-pi support */
#define TVM_OCCAM_PI 1
/* define to dispatch instructions using switch rather than a jump table */
#define TVM_DISPATCH_SWITCH 1
/* define for little-endian TVM */
#define TVM_LITTLE_ENDIAN 1
/* define to allow FPU usage */
#define TVM_USE_FPU 1
/* define to allow inline keyword usage */
#define TVM_USE_INLINE 1

#endif /* RUNTIME_TVM_CONFIG_H_SEEN */
