module magic;

extern (C):

enum MAGIC_NONE = 0x0000000; /* No flags */
enum MAGIC_DEBUG = 0x0000001; /* Turn on debugging */
enum MAGIC_SYMLINK = 0x0000002; /* Follow symlinks */
enum MAGIC_COMPRESS = 0x0000004; /* Check inside compressed files */
enum MAGIC_DEVICES = 0x0000008; /* Look at the contents of devices */
enum MAGIC_MIME_TYPE = 0x0000010; /* Return the MIME type */
enum MAGIC_CONTINUE = 0x0000020; /* Return all matches */
enum MAGIC_CHECK = 0x0000040; /* Print warnings to stderr */
enum MAGIC_PRESERVE_ATIME = 0x0000080; /* Restore access time on exit */
enum MAGIC_RAW = 0x0000100; /* Don't convert unprintable chars */
enum MAGIC_ERROR = 0x0000200; /* Handle ENOENT etc as real errors */
enum MAGIC_MIME_ENCODING = 0x0000400; /* Return the MIME encoding */
enum MAGIC_MIME = MAGIC_MIME_TYPE | MAGIC_MIME_ENCODING;
enum MAGIC_APPLE = 0x0000800; /* Return the Apple creator/type */
enum MAGIC_EXTENSION = 0x1000000; /* Return a /-separated list of
					   * extensions */
enum MAGIC_COMPRESS_TRANSP = 0x2000000; /* Check inside compressed files
					   * but not report compression */
enum MAGIC_NODESC = MAGIC_EXTENSION | MAGIC_MIME | MAGIC_APPLE;

enum MAGIC_NO_CHECK_COMPRESS = 0x0001000; /* Don't check for compressed files */
enum MAGIC_NO_CHECK_TAR = 0x0002000; /* Don't check for tar files */
enum MAGIC_NO_CHECK_SOFT = 0x0004000; /* Don't check magic entries */
enum MAGIC_NO_CHECK_APPTYPE = 0x0008000; /* Don't check application type */
enum MAGIC_NO_CHECK_ELF = 0x0010000; /* Don't check for elf details */
enum MAGIC_NO_CHECK_TEXT = 0x0020000; /* Don't check for text files */
enum MAGIC_NO_CHECK_CDF = 0x0040000; /* Don't check for cdf files */
enum MAGIC_NO_CHECK_CSV = 0x0080000; /* Don't check for CSV files */
enum MAGIC_NO_CHECK_TOKENS = 0x0100000; /* Don't check tokens */
enum MAGIC_NO_CHECK_ENCODING = 0x0200000; /* Don't check text encodings */
enum MAGIC_NO_CHECK_JSON = 0x0400000; /* Don't check for JSON files */

/* No built-in tests; only consult the magic file */

/*	MAGIC_NO_CHECK_SOFT	| */

enum MAGIC_SNPRINTB = "\177\020
b\0debug\0
b\1symlink\0
b\2compress\0
b\3devices\0
b\4mime_type\0
b\5continue\0
b\6check\0
b\7preserve_atime\0
b\10raw\0
b\11error\0
b\12mime_encoding\0
b\13apple\0
b\14no_check_compress\0
b\15no_check_tar\0
b\16no_check_soft\0
b\17no_check_sapptype\0
b\20no_check_elf\0
b\21no_check_text\0
b\22no_check_cdf\0
b\23no_check_reserved0\0
b\24no_check_tokens\0
b\25no_check_encoding\0
b\26no_check_json\0
b\27no_check_reserved2\0
b\30extension\0
b\31transp_compression\0
";

/* Defined for backwards compatibility (renamed) */
enum MAGIC_NO_CHECK_ASCII = MAGIC_NO_CHECK_TEXT;

/* Defined for backwards compatibility; do nothing */
enum MAGIC_NO_CHECK_FORTRAN = 0x000000; /* Don't check ascii/fortran */
enum MAGIC_NO_CHECK_TROFF = 0x000000; /* Don't check ascii/troff */

enum MAGIC_VERSION = 538; /* This implementation */

struct magic_set;
alias magic_t = magic_set*;
magic_t magic_open(int);
void magic_close(magic_t);

const(char)* magic_getpath(const(char)*, int);
const(char)* magic_file(magic_t, const(char)*);
const(char)* magic_descriptor(magic_t, int);
const(char)* magic_buffer(magic_t, const(void)*, size_t);

const(char)* magic_error(magic_t);
int magic_getflags(magic_t);
int magic_setflags(magic_t, int);

int magic_version();
int magic_load(magic_t, const(char)*);
int magic_load_buffers(magic_t, void**, size_t*, size_t);

int magic_compile(magic_t, const(char)*);
int magic_check(magic_t, const(char)*);
int magic_list(magic_t, const(char)*);
int magic_errno(magic_t);

enum MAGIC_PARAM_INDIR_MAX = 0;
enum MAGIC_PARAM_NAME_MAX = 1;
enum MAGIC_PARAM_ELF_PHNUM_MAX = 2;
enum MAGIC_PARAM_ELF_SHNUM_MAX = 3;
enum MAGIC_PARAM_ELF_NOTES_MAX = 4;
enum MAGIC_PARAM_REGEX_MAX = 5;
enum MAGIC_PARAM_BYTES_MAX = 6;

int magic_setparam(magic_t, int, const(void)*);
int magic_getparam(magic_t, int, void*);

/* _MAGIC_H */
