
#include <syslog.h>
#ifndef _IOS
#define _IOS
#endif

// Note: Only debug mode will print log. You could also set mode for log level.
#define kDebugMode
// LogLevelFatal , LogLevelError , LogLevelWarn , LogLevelInfo , LogLevelDebug
#define LogLevelFatal

#ifdef kDebugMode

static const int _IOS_FLAG_FATAL = 0x10;
static const int _IOS_FLAG_ERROR = 0x08;
static const int _IOS_FLAG_WARN  = 0x04;
static const int _IOS_FLAG_INFO  = 0x02;
static const int _IOS_FLAG_DEBUG = 0x01;

#ifdef LogLevelFatal
static const int _IOS_LOG_LEVEL = _IOS_FLAG_FATAL;
#elif defined(LogLevelError)
static const int _IOS_LOG_LEVEL = (_IOS_FLAG_FATAL | _IOS_FLAG_ERROR);
#elif defined(LogLevelWarn)
static const int _IOS_LOG_LEVEL = (_IOS_FLAG_FATAL | _IOS_FLAG_ERROR | _IOS_FLAG_WARN);
#elif defined(LogLevelInfo)
static const int _IOS_LOG_LEVEL = (_IOS_FLAG_FATAL | _IOS_FLAG_ERROR | _IOS_FLAG_WARN | _IOS_FLAG_INFO);
#elif defined(LogLevelDebug)
static const int _IOS_LOG_LEVEL = (_IOS_FLAG_FATAL | _IOS_FLAG_ERROR | _IOS_FLAG_WARN | _IOS_FLAG_INFO | _IOS_FLAG_DEBUG);
#endif



#define log4cplus_fatal(category, logFmt, ...) \
if(_IOS_LOG_LEVEL & _IOS_FLAG_FATAL) \
syslog(LOG_CRIT, "%s:" logFmt, category,##__VA_ARGS__); \

#define log4cplus_error(category, logFmt, ...) \
if(_IOS_LOG_LEVEL & _IOS_FLAG_ERROR) \
syslog(LOG_ERR, "%s:" logFmt, category,##__VA_ARGS__); \

#define log4cplus_warn(category, logFmt, ...) \
if(_IOS_LOG_LEVEL & _IOS_FLAG_WARN) \
syslog(LOG_WARNING, "%s:" logFmt, category,##__VA_ARGS__); \

#define log4cplus_info(category, logFmt, ...) \
if(_IOS_LOG_LEVEL & _IOS_FLAG_INFO) \
syslog(LOG_WARNING, "%s:" logFmt, category,##__VA_ARGS__); \

#define log4cplus_debug(category, logFmt, ...) \
if(_IOS_LOG_LEVEL & _IOS_FLAG_DEBUG) \
syslog(LOG_WARNING, "%s:" logFmt, category,##__VA_ARGS__); \


#else

#define log4cplus_fatal(category, logFmt, ...); \

#define log4cplus_error(category, logFmt, ...); \

#define log4cplus_warn(category, logFmt, ...); \

#define log4cplus_info(category, logFmt, ...); \

#define log4cplus_debug(category, logFmt, ...); \

#endif

