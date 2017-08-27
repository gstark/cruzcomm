import { extendObservable } from 'mobx'

class Store {
  constructor() {
    extendObservable(this, {
      showNav: false,
      username: '',
      menu: {
        title: 'APP TITLE',
        left: null,
        right: null
      }
    })
  }
}

const store = new Store()
export default store
