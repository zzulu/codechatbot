class Bots extends React.Component {
  render () {
    return (
      <React.Fragment>
        {this.props.bots.map((bot)=>(<Bot message={bot.message} response={bot.response}/>))}
      </React.Fragment>
    );
  }
}

Bots.propTypes = {
  bots: PropTypes.array
};

