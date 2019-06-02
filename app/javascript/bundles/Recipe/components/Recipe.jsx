import React, { Component } from "react";
import axios from "axios";

const headers = {
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-TOKEN": ReactOnRails.authenticityToken()
};

class Recipe extends Component {
  state = { userRecipe: {}, refetch: false };

  componentDidMount() {
    this.fetchRecipe();
  }
  componentDidUpdate() {
    this.state.refetch && this.fetchRecipe();
  }

  fetchRecipe = async _ => {
    const { recipeId } = this.props;
    const { data } = await axios.get(`/recipes/${recipeId}.json`);
    this.setState({ userRecipe: data.userRecipe, refetch: false });
  };

  handleRemoveRecipe = async _ => {
    const { userRecipe = {} } = this.state;
    await axios.delete(`/user_recipes/${userRecipe.id}`, { headers });
    this.setState({ refetch: true });
  };

  handleAddRecipe = async _ => {
    const { recipeId } = this.props;
    await axios.post("/user_recipes", { user_recipe: { id: recipeId } }, { headers });
    this.setState({ refetch: true });
  };

  render() {
    const { userRecipe } = this.state;
    return (
      <>
        {userRecipe ? (
          <button onClick={this.handleRemoveRecipe}>Remove from Cookbook</button>
        ) : (
          <button onClick={this.handleAddRecipe}>Add to Cookbook</button>
        )}
      </>
    );
  }
}

export default Recipe;
