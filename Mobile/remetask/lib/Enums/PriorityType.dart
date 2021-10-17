class Priority {

  static String parseToString(int priority)
  {
    switch(priority)
    {
      case 1:
        return 'Very low';
      case 2:
        return 'Low';
      case 3:
        return 'Average';
      case 4:
        return 'High';
      case 5:
        return 'Very high';
      default:
        return 'Not defined';
    }
  }
}