const String getProcessesQuery = r'''
  query GetProcesses($userId: String!) {
    processes(userId: $userId) {
      id
      policyId
      policyName
      policyVersion
      status
      variables
      initiatedAt
      completedAt
      history {
        nodeId
        nodeType
        nodeName
        status
        timestamp
        taskResult
      }
    }
  }
''';

const String getTasksQuery = r'''
  query GetTasks($userId: String!) {
    tasks(assignee: $userId) {
      id
      processInstanceId
      nodeId
      nodeName
      assignee
      createdAt
      dueDate
      status
      formData
      requiredDocuments
    }
  }
''';

const String getTaskDetailQuery = r'''
  query GetTaskDetail($taskId: String!) {
    task(id: $taskId) {
      id
      processInstanceId
      nodeId
      nodeName
      assignee
      createdAt
      dueDate
      status
      formData
      requiredDocuments
    }
  }
''';

const String getProcessDetailQuery = r'''
  query GetProcessDetail($processId: String!) {
    process(id: $processId) {
      id
      policyId
      policyName
      policyVersion
      status
      variables
      initiatedAt
      completedAt
      history {
        nodeId
        nodeType
        nodeName
        status
        timestamp
        taskResult
      }
    }
  }
''';

const String completeTaskMutation = r'''
  mutation CompleteTask($taskId: String!, $result: JSON!) {
    completeTask(input: {
      taskId: $taskId
      result: $result
    }) {
      success
      message
      task {
        id
        status
        completedAt
      }
    }
  }
''';

const String rejectTaskMutation = r'''
  mutation RejectTask($taskId: String!, $reason: String!) {
    rejectTask(taskId: $taskId, reason: $reason) {
      success
      message
      task {
        id
        status
      }
    }
  }
''';

const String uploadDocumentMutation = r'''
  mutation UploadDocument($processId: String!, $fileName: String!, $fileBase64: String!, $mimeType: String!) {
    uploadDocument(input: {
      processInstanceId: $processId
      fileName: $fileName
      fileData: $fileBase64
      mimeType: $mimeType
    }) {
      success
      message
      document {
        id
        fileName
        status
        uploadedAt
      }
    }
  }
''';

const String getNotificationsQuery = r'''
  query GetNotifications($userId: String!, $limit: Int!) {
    notifications(userId: $userId, limit: $limit) {
      id
      userId
      title
      body
      type
      relatedId
      createdAt
      read
    }
  }
''';

const String markAllNotificationsAsReadMutation = r'''
  mutation MarkAllNotificationsAsRead($userId: String!) {
    markAllNotificationsAsRead(userId: $userId) {
      success
      message
    }
  }
''';

const String markNotificationAsReadMutation = r'''
  mutation MarkAsRead($notificationId: String!) {
    markNotificationAsRead(id: $notificationId) {
      success
      message
    }
  }
''';

const String getDocumentsQuery = r'''
  query GetDocuments($processId: String!) {
    documents(processInstanceId: $processId) {
      id
      processInstanceId
      fileName
      fileType
      fileSize
      mimeType
      uploadedAt
      status
      rejectionReason
    }
  }
''';

const String getPublishedPoliciesQuery = r'''
  query GetPublishedPolicies {
    publishedPolicies {
      id
      name
      version
      status
      description
    }
  }
''';

const String startProcessMutation = r'''
  mutation StartProcess($input: JSON!) {
    startProcess(input: $input) {
      id
      policyId
      policyName
      policyVersion
      status
      variables
      initiatedAt
      completedAt
      history {
        nodeId
        nodeType
        nodeName
        status
        timestamp
        taskResult
      }
    }
  }
''';

const String getCurrentUserQuery = r'''
  query GetCurrentUser {
    currentUser {
      id
      username
      email
      departamento
      roles
      active
    }
  }
''';

const String getUserStatisticsQuery = r'''
  query GetUserStatistics($userId: String!) {
    userStatistics(userId: $userId)
  }
''';

const String getProcessHistoryQuery = r'''
  query GetProcessHistory($userId: String!, $limit: Int) {
    processHistory(userId: $userId, limit: $limit) {
      id
      policyId
      policyName
      policyVersion
      status
      variables
      initiatedAt
      completedAt
      history {
        nodeId
        nodeType
        nodeName
        status
        timestamp
        taskResult
      }
    }
  }
''';
