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
