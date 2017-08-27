import React, { Component } from 'react'
import { observer } from 'mobx-react'
import Navigation from './Navigation'
import Menu from './Menu'
import store from '../store'

class Layout extends Component {
  componentWillMount() {
    const username = window.localStorage.getItem('cc:username')
    if (store.username === '') {
      store.username = username || 'Tommy'
    }
  }

  render() {
    return (
      <div className="layout">
        <Menu visible={store.showNav} />
        {this.props.children}
        <Navigation visible={store.showNav} />
      </div>
    )
  }
}

export default observer(Layout)
