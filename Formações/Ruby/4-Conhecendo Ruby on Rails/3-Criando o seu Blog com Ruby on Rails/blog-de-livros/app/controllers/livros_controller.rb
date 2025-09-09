class LivrosController < ApplicationController
  before_action :set_livro, only: [:show, :edit, :update, :destroy]

  # GET /livros
  def index
    @livros = Livro.all
  end

  # GET /livros/1
  def show
  end

  # GET /livros/new
  def new
    @livro = Livro.new
  end

  # GET /livros/1/edit
  def edit
  end

  # POST /livros
  def create
    @livro = Livro.new(livro_params)

    if @livro.save
      redirect_to @livro, notice: 'Livro foi criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /livros/1
  def update
    if @livro.update(livro_params)
      redirect_to @livro, notice: 'Livro foi atualizado com sucesso.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /livros/1
  def destroy
    @livro.destroy!
    redirect_to livros_url, notice: 'Livro foi excluído com sucesso.', status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_livro
      @livro = Livro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def livro_params
      params.require(:livro).permit(:titulo, :autor, :nota, :descricao, :url)
    end
end
