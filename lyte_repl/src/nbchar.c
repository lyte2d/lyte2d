/* (c) mg */

#if defined(_WIN32)

#include <conio.h>
#include <stdio.h>
int nbchar(void) {
    if(_kbhit()) {
        return 1;
    }
    return 0;
}

int _t = 0;

#elif defined(__linux__)

/**
 * https://www.flipcode.com/archives/_kbhit_for_Linux.shtml

 Linux (POSIX) implementation of _kbhit().
 Morgan McGuire, morgan@cs.brown.edu
 */
#include <stdbool.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>
#include <termios.h>
// #include <stropts.h>
#include <fcntl.h>

void nbchar_enable_raw_mode(void)
{
    struct termios term;
    tcgetattr(0, &term);
    term.c_lflag &= ~(ICANON | ECHO); // Disable echo as well
    tcsetattr(0, TCSANOW, &term);
}

void nbchar_disable_raw_mode(void)
{
    struct termios term;
    tcgetattr(0, &term);
    term.c_lflag |= ICANON | ECHO;
    tcsetattr(0, TCSANOW, &term);
}

static bool kbhit(void)
{
    int byteswaiting;
    ioctl(0, FIONREAD, &byteswaiting);
    return byteswaiting > 0;
}

int nbchar(void) {
   nbchar_enable_raw_mode();
    int ret = 0;
    int hit = kbhit();
    nbchar_disable_raw_mode();
    if (hit) {
        ret = 1;
    }
    tcflush(0, TCIFLUSH);
    return ret;
}

#else
int nbchar(void) { return 0; }
#endif

