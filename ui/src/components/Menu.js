import React from 'react'
import { observer } from 'mobx-react'
import cx from 'classnames'

import store from '../store'

const Menu = ({ visible }) =>
  <nav className={cx('menu', { visible })}>
    <div className="item left">
      {store.menu.left}
    </div>
    <h2>
      {store.menu.title}
    </h2>
    <div className="item right">
      {store.menu.right}
    </div>
  </nav>

export default observer(Menu)
