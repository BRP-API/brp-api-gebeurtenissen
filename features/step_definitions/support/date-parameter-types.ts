import {defineParameterType} from '@cucumber/cucumber';

defineParameterType({
  name: 'dd-mm-yyyy datum',
  regexp: /\d{1,2}-\d{1,2}-\d{4}/,
  transformer: (dateString: string) => {
    const [day, month, year] = dateString.split('-').map(Number);
    return `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
  },
});
