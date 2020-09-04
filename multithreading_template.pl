#!/usr/bin/perl
# Template for multithreading in perl

use strict;
use warnings;
use threads;

my $n_threads = 4; # How many processes that will be done in parallel
my @thr = ();

# Loop that starts multiple tasks in parallel on separate threads
for (my $i = 0; $i < $n_threads; $i++) {
    $thr[$i] = threads->create({'context' => 'list'}, \&generic_sub, $i);
}

# To return calculations from threads
for (my $i = 0; $i < $n_threads; $i++) {
    my ($returned_tid, $returned_sum) = $thr[$i]->join();
    print "The thread with thread ID " . $returned_tid . " got the sum " . $returned_sum . "\n";
}

# Subroutine that is done multiple times in parallel
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
