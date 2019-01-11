import React, { Component } from 'react';

class Timer extends Component {
  state = {
    timer:600000,
    endTime: 0 
  };
  render() {
    return (
      <div>
          Can't call an app taaamer
          <form>
            <input type="range" min="600000" max="3600000" step="600000" onChange={this.handleChange}></input>
            <button  onClick={(e) => {
          this.handleSubmit(e)
        }}>Set Time</button>
          </form>
          <p>{this.state.endTime}</p>
      </div>
    );
  }
  componentDidMount() {
    const { methods } = this.props.drizzle.contracts.Election;
    methods.StartTime().call()
  }
  handleChange = (e) => {
    this.setState({timer: e.target.value})
    console.log(this.state.timer)
  }
  handleSubmit = (e) => {
    e.preventDefault();
    const { methods } = this.props.drizzle.contracts.Election;
    methods.setEndTime.cacheSend(this.state.timer).then(() => {
      methods.EndTime.call().then(console.log)
    })
  }
}

export default Timer;