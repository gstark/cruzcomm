import React from 'react'
import { NavLink } from 'react-router-dom'
import cx from 'classnames'
import { Icon } from 'react-fa'

const Navigation = ({ visible }) =>
  <nav className={cx('navigation', { visible })}>
    <ul>
      <NavigationButton path="/call" icon="phone" />
      <NavigationButton path="/chat" icon="comments" />
      <NavigationButton path="/maps" icon="compass" />
      <NavigationButton path="/ship" icon="ship" />
      <NavigationButton path="/news" icon="globe" />
    </ul>
  </nav>

const NavigationButton = ({ path, icon }) =>
  <li>
    <NavLink to={path}>
      <Icon name={icon} size="2x" />
    </NavLink>
  </li>

export default Navigation
