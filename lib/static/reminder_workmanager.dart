enum ReminderWorkmanager {
  periodicTask("reminder lunch", "identifier lunch");

  final String uniqueName;
  final String taskName;

  const ReminderWorkmanager(this.uniqueName, this.taskName);
}