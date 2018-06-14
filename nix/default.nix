{ sockets, cores, threads, responsive }:
let
  # Calculate total cores and threads available on this system.
  totalCores = sockets * cores;
  totalThreads = totalCores * threads;

  # Leave at least one available core for a responsive system.
  responsiveThreads = if responsive then 1 else 0;

  # Raise niceness if we want a responsive system.
  niceness = if responsive then 5 else 0;
in
{
  # Users in the wheel group have access to the Nix daemon
  allowedUsers = [ "@wheel" ];

  # Detect files with duplicate contents and hard-link them.
  autoOptimiseStore = true;

  # Build with all cores, but leave one if we want responsiveness.
  buildCores = totalThreads - responsiveThreads;

  # Minimize number of jobs to prioritize large, single builds.
  maxJobs = 1;

  # Sets how 'nicely' the Nix daemon schedules with other threads.
  daemonNiceLevel = niceness;
  daemonIONiceLevel = niceness;

  # Run garbage collector automatically at midnight.
  gc.automatic = true;
  gc.dates = "00:00";

  # Prevents writing to the Nix store.
  readOnlyStore = true;
}
