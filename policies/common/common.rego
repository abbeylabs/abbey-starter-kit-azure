package common

import data.abbey.functions

allow[msg] {
    functions.expire_after("30m")
    msg := "granting access for 30m minutes"
}
