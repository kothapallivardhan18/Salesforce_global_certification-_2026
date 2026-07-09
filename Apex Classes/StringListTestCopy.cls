public class StringListTestCopy {

    public static List<String> generateStringListCopy(Integer IntegerCopy) {

        List<String> stringList = new List<String>();

        for (Integer i = 0; i < IntegerCopy; i++) {
            stringList.add('Test ' + i);
        }

        return stringList;
    }
}
