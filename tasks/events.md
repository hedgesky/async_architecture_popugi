## Event storming (kind of)

### Tasks tracker

| Actor | Command | Event | Requirement |
|-|-|-|-|
| Account[Any] | LogInToTasks | LoggedInToTasks | Таск-трекер должен быть .. доступен всем сотрудникам |
| Account[Any] | CreateTask | TaskCreated | Новые таски может создавать кто угодно |
| Account[Manager, Admin] | AssignTasks | TaskAssigned (N штук) | Менеджеры или администраторы должны иметь кнопку «заассайнить задачи» |
| Account[Any] | CompleteTask | TaskCompleted | Каждый сотрудник должен иметь возможность ... отметить задачу выполненной. |
| TaskAssigned event | SendAssignmentNotification | AssignmentNotificationSent | После ассайна новой задачи сотруднику должно приходить оповещение... |

### Accounting

| Actor | Command | Event | Requirement |
|-|-|-|-|
| Account[Admin, Accountant] | LogInToAccounting | LoggedInToAccounting | Аккаунтинг должен быть ... доступным только для администраторов и бухгалтеров. |
| TaskAssigned event | CreateAuditLogEntry | AuditLogEntryCreated | У сотрудника появилась новая задача — rand(-10..-20)$ |
| TaskCompleted event | CreateAuditLogEntry | AuditLogEntryCreated | Cотрудник выполнил задачу — rand(20..40)$ |
| AuditLogEntryCreated event  | UpdateEmployeeBalance | EmployeeBalanceUpdated  | У каждого из сотрудников должен быть свой счет, который показывает, сколько за сегодня он получил денег |
| DayHasPassed event | CalculateDailyEarnings | DailyEarningsCalculated | В конце дня необходимо считать, сколько денег сотрудник получил за рабочий день |
| DailyEarningsCalculated event | SendDailyEarningsNotifications | DailyEarningsNotificationsSent | В конце дня необходимо считать ... слать на почту сумму выплаты. |
| DailyEarningsCalculated event | PayPositiveEarnings | PositiveEarningsPaid | После выплаты баланса (в конце дня) _Неявно сказано, что будут происходить выплаты_ |
| PositiveEarningsPaid event | CreateAuditLogEntry | AuditLogEntryCreated | После выплаты баланса он должен обнуляться |

### Analytics

| Actor | Command | Event | Requirement |
|-|-|-|-|
| Account[Admin] | LogInToAnalytics | LoggedInToAnalytics | Аналитика доступна только админам |