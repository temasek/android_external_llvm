; RUN: llc < %s -mtriple=x86_64-darwin -mcpu=corei7 | grep movabsq | count 3

define i64 @constant_hoisting(i64 %o0, i64 %o1, i64 %o2, i64 %o3, i64 %o4, i64 %o5) {
entry:
  %l0 = and i64 %o0, -281474976710654
  %c0 = icmp ne i64 %l0, 0
  br i1 %c0, label %fail, label %bb1

bb1:
  %l1 = and i64 %o1, -281474976710654
  %c1 = icmp ne i64 %l1, 0
  br i1 %c1, label %fail, label %bb2

bb2:
  %l2 = and i64 %o2, -281474976710654
  %c2 = icmp ne i64 %l2, 0
  br i1 %c2, label %fail, label %bb3

bb3:
  %l3 = and i64 %o3, -281474976710654
  %c3 = icmp ne i64 %l3, 0
  br i1 %c3, label %fail, label %bb4

bb4:
  %l4 = and i64 %o4, -281474976710653
  %c4 = icmp ne i64 %l4, 0
  br i1 %c4, label %fail, label %bb5

bb5:
  %l5 = and i64 %o5, -281474976710652
  %c5 = icmp ne i64 %l5, 0
  br i1 %c5, label %fail, label %bb6

bb6:
  ret i64 %l5

fail:
  ret i64 -1
}

define void @constant_expressions() {
entry:
  %0 = load i64* inttoptr (i64 add (i64 51250129900, i64 0) to i64*)
  %1 = load i64* inttoptr (i64 add (i64 51250129900, i64 8) to i64*)
  %2 = load i64* inttoptr (i64 add (i64 51250129900, i64 16) to i64*)
  %3 = load i64* inttoptr (i64 add (i64 51250129900, i64 24) to i64*)
  %4 = add i64 %0, %1
  %5 = add i64 %2, %3
  %6 = add i64 %4, %5
  store i64 %6, i64* inttoptr (i64 add (i64 51250129900, i64 0) to i64*)
  ret void
}


define void @constant_expressions2() {
entry:
  %0 = load i64* inttoptr (i64 51250129900 to i64*)
  %1 = load i64* inttoptr (i64 51250129908 to i64*)
  %2 = load i64* inttoptr (i64 51250129916 to i64*)
  %3 = load i64* inttoptr (i64 51250129924 to i64*)
  %4 = add i64 %0, %1
  %5 = add i64 %2, %3
  %6 = add i64 %4, %5
  store i64 %6, i64* inttoptr (i64 51250129900 to i64*)
  ret void
}

