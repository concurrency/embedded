#ifndef COMPILER_CONFIG_H_SEEN
#define COMPILER_CONFIG_H_SEEN

/* Set if compiling ilibr & tcofflib under a UNIX. */
#define TARGET_OS_IS_UNIX 1
/* Set if compiling ilibr & tcofflib with GCC. */
#define COMPILER_IS_GCC 1
/* Set if compiling for an x86 platform. */
#define TARGET_CPU_IS_I386 1
/* Unconditional */
#define OC 1
/* Unconditional */
#define OCCAM2_5 1
/* Target CPU */
#define TARGET_CANONICAL "i386"
/* Define to target KROC ETC. */
#define CODE_GEN_KROC_ASM 1
/* To enable user-defined operators. */
#define USER_DEFINED_OPERATORS 1
/* Default enabled. */
#define MOBILES 1
/* Default enabled. */
#define PROCESS_PRIORITY 1
/* Depends on compiler... GCC OK? */
#define CAN_USE_INLINE 1
/* Default enabled. */
#define INITIAL_DECL 1
/* This has not changed for 10 years... why start now? */
#define VERSION "1.4.0"

/* The size of `signed int', as computed by sizeof. */
#define SIZEOF_SIGNED_INT 4

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <stdarg.h> header file. */
#define HAVE_STDARG_H 1

/* Define to 1 if you have the <malloc.h> header file. */
/* #undef HAVE_MALLOC_H */

#endif /* COMPILER_CONFIG_H_SEEN */
