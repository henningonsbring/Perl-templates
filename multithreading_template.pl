#!/usr/bin/perl
# Template for multithreading in perl

use strict;
use warnings;
use threads;

my $global_num = 0;
my $n_threads = 4;
my @thr = ();

for (my $i = 0; $i < $n_threads; $i++) {
    $thr[$i] = threads->create({'context' => 'list'}, \&generic_sub, $i);
}

for (my $i = 0; $i < $n_threads; $i++) {
    my ($returned_tid, $returned_sum) = $thr[$i]->join();
    print "The thread with thread ID " . $returned_tid . " got the sum " . $returned_sum . "\n";
}

sub generic_sub {
    my ($thread_id) = @_;
    print "Thread " . $thread_id . " started" . "\n";
    my $sum = 0;
    for (my $i = 0; $i < 10000000; $i++) {
        $sum = $sum + rand();
    }
    print "Thread " . $thread_id . " done" . "\n";
    return ($thread_id, $sum);
}
