#!/bin/bash
if [ "$(nproc --all)" -eq 6 ]; then
    # Guest VM
    # ALLOW_CPUS="0"
    RT_CPUS="0,1,2,3,4,5"
    SV_IRQ_CPU="0"
    echo RT_RUNTIME_SHARE > /sys/kernel/debug/sched/features
else
    # QCOM hypervisor host.
    ALLOW_CPUS="0,1"
    RT_CPUS="2,3,4,5,6,7"
    SV_IRQ_CPU="1"
    echo 1 > /sys/devices/system/cpu/cpufreq/boost
fi
SV_INTERFACE="end0"

for policy in /sys/devices/system/cpu/cpufreq/policy*; do
    [ -w "$policy/scaling_governor" ] && echo performance > "$policy/scaling_governor"
    [ -w "$policy/scaling_min_freq" ] && echo 2361600 > "$policy/scaling_min_freq"
done

for cpu in $(echo "$RT_CPUS" | tr ',' ' '); do
    for cpuidle_state in /sys/devices/system/cpu/cpu$cpu/cpuidle/state*; do
        [ -w "$cpuidle_state/disable" ] && echo 1 > "$cpuidle_state/disable"
    done
done

echo 0 > /proc/sys/kernel/timer_migration
echo -1 > /proc/sys/kernel/sched_rt_runtime_us

cpu_list_to_mask() {
   MASK=0
   for cpu in $(echo $1 | tr ',' ' '); do
      MASK=$((MASK | (1 << cpu)))
   done
   printf "%x\n" "$MASK"
}

MASK=$(cpu_list_to_mask "$ALLOW_CPUS")
for wq in /sys/devices/virtual/workqueue/*; do
   [ -w "$wq/cpumask" ] && echo "$MASK" > "$wq/cpumask"
done

echo "Setting IRQ affinity to CPUs: $ALLOW_CPUS (mask=0x$MASK)"
for irq in /proc/irq/[0-9]*; do
   smp_file="$irq/smp_affinity"
   [ -w "$smp_file" ] && echo "$MASK" > "$smp_file" 2>/dev/null
done

MASK=$(cpu_list_to_mask "$SV_IRQ_CPU")
echo "Setting SV_IRQ affinity to CPUs: $SV_IRQ_CPU (mask=0x$MASK)"
for irq in $(grep $SV_INTERFACE /proc/interrupts | grep -E "^[0-9]+" -o); do
   echo "$MASK" > "/proc/irq/$irq/smp_affinity"
done
