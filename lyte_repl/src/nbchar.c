/* (c) mg */

#if defined(_WIN32)

#include <conio.h>
#include <stdio.h>
int nbchar() {
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
#include <stropts.h>
#include <fcntl.h>

void nbchar_enable_raw_mode()
{
    struct termios term;
    tcgetattr(0, &term);
    term.c_lflag &= ~(ICANON | ECHO); // Disable echo as well
    // term.c_lflag &= ~(ICANON); // (try not?) Disable echo as well
    tcsetattr(0, TCSANOW, &term);
}

void nbchar_disable_raw_mode()
{
    struct termios term;
    tcgetattr(0, &term);
    term.c_lflag |= ICANON | ECHO;
    // term.c_lflag |= ICANON ;
    tcsetattr(0, TCSANOW, &term);


}

static bool kbhit()
{
    int byteswaiting;
    ioctl(0, FIONREAD, &byteswaiting);
    return byteswaiting > 0;
}


// int kbhit(void)
// {
//   struct termios oldt, newt;
//   int ch;
//   int oldf;

//   tcgetattr(STDIN_FILENO, &oldt);
//   newt = oldt;
//   newt.c_lflag &= ~(ICANON | ECHO);
//   tcsetattr(STDIN_FILENO, TCSANOW, &newt);
//   oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
//   fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

//   ch = getchar();

//   tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
//   fcntl(STDIN_FILENO, F_SETFL, oldf);

//   if(ch != EOF)
//   {
//     ungetc(ch, stdin);
//     return 1;
//   }

//   return 0;
// }


// int kbhit() {
//     static const int STDIN = 0;
//     static bool initialized = false;

//     if (! initialized) {
//         // Use termios to turn off line buffering
//         struct termios term;
//         tcgetattr(STDIN, &term);
//         term.c_lflag &= ~ICANON;
//         tcsetattr(STDIN, TCSANOW, &term);
//         setbuf(stdin, NULL);
//         initialized = true;
//     }

//     int bytesWaiting;
//     ioctl(STDIN, FIONREAD, &bytesWaiting);
//     return bytesWaiting;
// }



// int kbhit(void)
// {
//   struct termios oldt, newt;
//   int ch;
//   int oldf;

//   tcgetattr(STDIN_FILENO, &oldt);
//   newt = oldt;
//   newt.c_lflag &= ~(ICANON | ECHO);
//   tcsetattr(STDIN_FILENO, TCSANOW, &newt);
//   oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
//   fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

//   ch = getchar();

//   tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
//   fcntl(STDIN_FILENO, F_SETFL, oldf);

//   if(ch != EOF)
//   {
//     ungetc(ch, stdin);
//     return ch;
//   }

//   return 0;
// }


int nbchar() {
   nbchar_enable_raw_mode();
    int ret = 0;
    int hit = kbhit();
    nbchar_disable_raw_mode();
    if (hit) {
        //ret = getchar();
        //ungetc(ret, stdin);
        ret = 1;
    }
    tcflush(0, TCIFLUSH);
    return ret;
}

#else
int nbchar(void) { return 0; }
#endif

