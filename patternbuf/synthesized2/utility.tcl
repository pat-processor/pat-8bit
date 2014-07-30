namespace eval control {
    namespace export waitForAny
    variable waitForAnyKey 0

    # new "vwait" that takes multiple variables and/or optional timeout
    # usage:  waitForAny ?timeout? variable ?variable ...?
    proc waitForAny {args} {
        variable waitForAnyArray
        variable waitForAnyKey

        # if first arg is a number, then that is max wait time
        if {[string is int [lindex $args 0]]} {
            set timeout [lindex $args 0]
            set args [lrange $args 1 end]
        }

        # create trigger script that will cause vwait to fall thru
        # (trailing comment is to eat appended args in trace command)
        set index "Key[incr waitForAnyKey]"
        set trigger "[namespace code [list set waitForAnyArray($index) 1]] ;#"

        # create trace to trip trigger
        foreach var $args {
            uplevel \#0 [list trace variable $var w $trigger]
        }

        # set timer is user requested one
        if {[info exists timeout]} {
            set timerId [after $timeout $trigger]
        }
        vwait [namespace which -variable waitForAnyArray]($index)

        # remove all traces
        foreach var $args {
            uplevel \#0 [list trace vdelete $var w $trigger]
        }

        # cancel timer
        if [info exists timerId] {
            after cancel $timerId
        }
        # cleanup
        unset waitForAnyArray($index)
    }
}


proc pause {{message "Hit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}


proc next {{message "Continue y/n?"}} {
global interactive 
if (!$interactive) {
    puts $message
    flush stdout
    set answer [gets stdin]
    if (![string compare $answer "n"]) { break }
  }
}
