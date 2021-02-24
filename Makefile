CFLAGS += -Wall -Wstrict-prototypes -O3
ALL_CFLAGS += $(CFLAGS) -std=c99 -pedantic

ifneq ($(V), 1)
        NICE_CC = @echo "  CC  $@"; $(CC)
else
        NICE_CC = $(CC)
endif

default: seccomp_user_notification seccomp_unotify_mkdir seccomp_addfd send_addfd send_addfd_maxfds_err

%.o: %.c
	$(NICE_CC) -I/seccompnotify/rataexample/header/  $(ALL_CFLAGS) -c $< -o $@

seccomp_user_notification: seccomp_user_notification.o scm_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@

seccomp_rata: seccomp_rata.o scm_functions.o seccomp_functions.o get_num.o error_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@

seccomp_addfd: seccomp_addfd.o scm_functions.o seccomp_functions.o get_num.o error_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@

send_addfd: send_addfd.o scm_functions.o seccomp_functions.o get_num.o error_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@

send_addfd_maxfds_err: send_addfd_maxfds_err.o scm_functions.o seccomp_functions.o get_num.o error_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@


seccomp_unotify_mkdir: seccomp_unotify_mkdir.o scm_functions.o seccomp_functions.o get_num.o error_functions.o
	$(NICE_CC) $^ $(LDFLAGS) -o $@

clean:
	@echo "  CLEAN"
	@rm -f *.o seccomp_user_notification seccomp_unotify_mkdir


.PHONY: default clean
